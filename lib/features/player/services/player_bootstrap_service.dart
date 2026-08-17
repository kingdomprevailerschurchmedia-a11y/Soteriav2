import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../personalization/utils/personalization_bridge.dart';
import '../domain/models/player_profile.dart';
import '../domain/models/player_progression.dart';
import '../domain/use_cases/load_player_profile_use_case.dart';
import '../domain/use_cases/create_player_profile_use_case.dart';
import '../domain/use_cases/update_player_profile_use_case.dart';
import '../domain/repositories/player_progression_repository.dart';
import '../domain/services/progression_service.dart';
import '../domain/repositories/goal_repository.dart';
import '../../question_content/domain/repositories/category_repository.dart';
import '../../../core/logging/logger_service.dart';
import '../../../core/identity/repositories/identity_repository.dart';

class PlayerBootstrapService {
  final LoadPlayerProfileUseCase _loadProfile;
  final CreatePlayerProfileUseCase _createProfile;
  final UpdatePlayerProfileUseCase _updateProfile;
  final PlayerProgressionRepository _progressionRepository;
  final ProgressionService _progressionService;
  final FirebaseFirestore _firestore;
  final IdentityRepository? _identityRepository;
  final CategoryRepository? _categoryRepository;
  final GoalRepository? _goalRepository;

  static const _kPersonalizationKey = 'user_personalization';

  PlayerBootstrapService(
    this._loadProfile,
    this._createProfile,
    this._updateProfile,
    this._progressionRepository,
    this._progressionService,
    this._firestore, {
    IdentityRepository? identityRepository,
    CategoryRepository? categoryRepository,
    GoalRepository? goalRepository,
  }) : _identityRepository = identityRepository,
       _categoryRepository = categoryRepository,
       _goalRepository = goalRepository;

  Future<PlayerProfile> bootstrap(auth.User user) async {
    LoggerService.i(
      'Bootstrapping player profile for: ${user.uid}',
      feature: 'Player',
    );

    try {
      final existingProfile = await _loadProfile.execute(user.uid);
      final localInterests = await _getInterestsFromLocal();

      // Ensure categories are seeded in background
      _categoryRepository?.seedDefaultCategories();
      
      // Ensure goals are populated for the day
      _goalRepository?.refreshGoals(user.uid);

      if (existingProfile != null) {
        LoggerService.i(
          'Existing profile found, updating last login',
          feature: 'Player',
        );

        // Sync interests if remote profile is missing them
        List<String> mergedInterests = existingProfile.favoriteCategories;
        if (mergedInterests.isEmpty) {
          if (localInterests.isNotEmpty) {
            mergedInterests = localInterests;
          } else if (_identityRepository != null) {
            // Fallback: Check user_profiles collection for interests saved during registration
            final userIdentityProfile = await _identityRepository!.getUserProfile(user.uid);
            if (userIdentityProfile != null && userIdentityProfile.interests.isNotEmpty) {
               mergedInterests = userIdentityProfile.interests.map((label) => PersonalizationBridge.labelToCategoryId(label)).toList();
            }
          }
        }

        final now = DateTime.now();
        int newStreak = existingProfile.currentStreak;
        bool shouldReward = false;

        // Calculate Streak
        if (_isYesterday(existingProfile.lastLogin, now)) {
          newStreak++;
          // Reward every 7 days
          if (newStreak % 7 == 0) {
            shouldReward = true;
          }
        } else if (!_isSameDay(existingProfile.lastLogin, now)) {
          // Missed a day or more, reset to 1
          newStreak = 1;
        }

        // We use an atomic patch here to avoid overwriting concurrent changes 
        // to other fields like 'coins' from reward claims.
        final patchData = {
          'lastLogin': Timestamp.fromDate(now),
          'updatedAt': Timestamp.fromDate(now),
          'favoriteCategories': mergedInterests,
          'currentStreak': newStreak,
          'highestStreak': newStreak > existingProfile.highestStreak 
              ? newStreak 
              : existingProfile.highestStreak,
        };

        if (shouldReward) {
          patchData['coins'] = FieldValue.increment(500);
          
          final txRef = _firestore.collection('coin_transactions').doc();
          patchData['lastCoinTransactionId'] = txRef.id; // Optional: track last tx in user doc
          
          // Log the transaction
          await _firestore.collection('coin_transactions').doc(txRef.id).set({
            'userId': user.uid,
            'type': 'coins',
            'direction': 'credit',
            'amount': 500,
            'source': 'streak',
            'status': 'completed',
            'createdAt': FieldValue.serverTimestamp(),
            'metadata': {'streakCount': newStreak},
          });

          // Sync with wallets collection for Economy screen
          await _firestore.collection('wallets').doc(user.uid).set({
            'coins': FieldValue.increment(500),
            'lifetimeCoinsEarned': FieldValue.increment(500),
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
          
          LoggerService.i('7-day streak reached! Granting 500 bonus coins via increment and logging transaction.', feature: 'Player');
        }

        await _firestore.collection('users').doc(user.uid).update(patchData);

        final updatedProfile = existingProfile.copyWith(
          lastLogin: now,
          updatedAt: now,
          favoriteCategories: mergedInterests,
          currentStreak: newStreak,
          highestStreak: newStreak > existingProfile.highestStreak 
              ? newStreak 
              : existingProfile.highestStreak,
          coins: shouldReward ? existingProfile.coins + 500 : existingProfile.coins,
        );

        // Lazy Progression Migration
        await _migrateProgressionIfMissing(user.uid, existingProfile);

        return updatedProfile;
      } else {
        LoggerService.i(
          'No profile found, creating initial profile',
          feature: 'Player',
        );
        
        List<String> initialInterests = localInterests;
        if (initialInterests.isEmpty && _identityRepository != null) {
           final userIdentityProfile = await _identityRepository!.getUserProfile(user.uid);
            if (userIdentityProfile != null && userIdentityProfile.interests.isNotEmpty) {
               initialInterests = userIdentityProfile.interests.map((label) => PersonalizationBridge.labelToCategoryId(label)).toList();
            }
        }

        final now = DateTime.now();
        final newProfile = PlayerProfile(
          uid: user.uid,
          displayName: user.displayName ?? 'Scholar',
          email: user.email ?? '',
          photoUrl: user.photoURL ?? '',
          favoriteCategories: initialInterests,
          createdAt: now,
          lastLogin: now,
          updatedAt: now,
        );
        await _createProfile.execute(newProfile);

        // Initialize new progression record
        await _initializeNewProgression(user.uid);

        return newProfile;
      }
    } catch (e, st) {
      LoggerService.e(
        'Player bootstrap failed',
        error: e,
        stackTrace: st,
        feature: 'Player',
      );
      rethrow;
    }
  }

  Future<void> _migrateProgressionIfMissing(
    String userId,
    PlayerProfile profile,
  ) async {
    final existingProg = await _progressionRepository.getProgression(userId);
    if (existingProg != null) return; // Already migrated

    LoggerService.i(
      'Migrating legacy progression for user: $userId',
      feature: 'Player',
    );

    // 1. Resolve legacy XP
    int legacyXp = profile.xp;
    int playersXp = 0;

    try {
      final playersDoc = await _firestore.collection('players').doc(userId).get();
      if (playersDoc.exists) {
        playersXp = playersDoc.data()?['xp'] ?? 0;
      }
    } catch (e) {
      LoggerService.w('Could not read from players collection: $e', feature: 'Player');
    }

    // 2. Conflict Check
    if (legacyXp > 0 && playersXp > 0) {
      final diff = (legacyXp - playersXp).abs();
      if (diff > (legacyXp * 0.2) && diff > 500) {
        LoggerService.e(
          'CRITICAL: Progression conflict detected for $userId. users.xp=$legacyXp, players.xp=$playersXp. Migration halted.',
          feature: 'Player',
        );
        return; // Safety Stop
      }
    }

    final finalXp = legacyXp > playersXp ? legacyXp : playersXp;

    // 3. Create initial record
    // We use addXp to calculate level correctly from XP 0 using the new formula
    final initial = PlayerProgression.initial(userId, 'current_season');
    final migrated = _progressionService.addXp(initial, finalXp).copyWith(
      dailyStreak: profile.currentStreak,
      longestStreak: profile.highestStreak,
    );

    await _progressionRepository.updateProgression(migrated);
    
    LoggerService.i(
      'Successfully migrated progression: Level ${migrated.currentLevel}, XP ${migrated.lifetimeXp}',
      feature: 'Player',
    );
  }

  Future<void> _initializeNewProgression(String userId) async {
    final initial = PlayerProgression.initial(userId, 'current_season');
    await _progressionRepository.updateProgression(initial);
  }

  Future<List<String>> _getInterestsFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_kPersonalizationKey);
      if (data == null) return [];

      final Map<String, dynamic> map = jsonDecode(data);
      final interests = (map['interests'] as List<dynamic>).cast<String>();
      
      return interests.map((label) => PersonalizationBridge.labelToCategoryId(label)).toList();
    } catch (e) {
      return [];
    }
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  bool _isYesterday(DateTime last, DateTime now) {
    final yesterday = now.subtract(const Duration(days: 1));
    return _isSameDay(last, yesterday);
  }
}
