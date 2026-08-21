import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/identity/models/user_profile.dart';
import '../../domain/models/player_profile.dart';
import '../../domain/models/player_progression.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../domain/repositories/player_progression_repository.dart';
import '../models/player_profile_dto.dart';
import '../models/public_profile_dto.dart';
import '../../domain/models/public_competitive_profile.dart';
import '../../domain/models/competitive_statistics.dart';

class FirestoreProfileRepository implements ProfileRepository {
  final FirebaseFirestore _firestore;
  final LeaderboardRepository _leaderboardRepository;
  final PlayerProgressionRepository _progressionRepository;

  FirestoreProfileRepository(
    this._firestore,
    this._leaderboardRepository,
    this._progressionRepository,
  );

  @override
  Future<bool> checkUsernameAvailability(String username) async {
    final normalized = username.trim().toLowerCase();
    final doc = await _firestore.collection('usernames').doc(normalized).get();
    
    if (!doc.exists) return true;
    
    // If it exists, check if it belongs to the current user (case insensitive comparison)
    // We get the current user ID from the reservation document
    final data = doc.data();
    final userId = data?['userId'] as String?;
    
    // Note: We don't have the current UID here directly, so we rely on the caller 
    // or assume if it exists it's taken, but the rules allow the owner to overwrite it.
    // However, for availability UI, we should probably know if it's "taken by ME".
    // For now, let's keep it simple: if doc exists, it's not "available" for a NEW reservation.
    return !doc.exists;
  }

  @override
  Future<void> updateProfile({
    required String userId,
    required UserProfile userProfile,
    required PlayerProfile playerProfile,
    String? oldUsername,
  }) async {
    await _firestore.runTransaction((transaction) async {
      final newUsername = userProfile.username.toLowerCase();
      final usernameDoc = _firestore.collection('usernames').doc(newUsername);
      final progressionDoc =
          _firestore.collection('player_progression').doc(userId);

      // 1. ALL READS FIRST
      DocumentSnapshot? usernameSnapshot;
      if (oldUsername?.toLowerCase() != newUsername) {
        usernameSnapshot = await transaction.get(usernameDoc);
      }
      final progressionSnapshot = await transaction.get(progressionDoc);

      // 2. LOGIC & VALIDATION
      if (usernameSnapshot != null && usernameSnapshot.exists) {
        final data = usernameSnapshot.data() as Map<String, dynamic>?;
        if (data?['userId'] != userId) {
          throw Exception('Username already taken');
        }
      }

      // 3. ALL WRITES AFTER

      // Username reservation
      if (oldUsername?.toLowerCase() != newUsername) {
        // If we are changing username or setting it for the first time
        if (oldUsername != null && oldUsername.isNotEmpty) {
          transaction.delete(
            _firestore.collection('usernames').doc(oldUsername.toLowerCase()),
          );
        }

        transaction.set(usernameDoc, {
          'userId': userId,
          'username': userProfile.username,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Just ensure it exists if it's the same (handles casing updates or safety sync)
        transaction.set(
          usernameDoc,
          {'userId': userId, 'username': userProfile.username},
          SetOptions(merge: true),
        );
      }

      // User Profile
      final userProfileMap = userProfile.toMap();
      final restrictedUserProfileFields = [
        'email', 'country', 'timezone', 'language',
        'academicLevel', 'institution', 'faculty', 'department',
        'interests'
      ];
      for (final field in restrictedUserProfileFields) {
        userProfileMap.remove(field);
      }
      userProfileMap['updatedAt'] = FieldValue.serverTimestamp();

      transaction.set(
        _firestore.collection('user_profiles').doc(userId),
        userProfileMap,
        SetOptions(merge: true),
      );

      // Player Profile
      final playerProfileMap = PlayerProfileDto.toFirestore(playerProfile);
      final restrictedPlayerFields = [
        'xp', 'level', 'isPro', 'badges', 'achievements',
        'gamesPlayed', 'gamesWon', 'accuracy',
        'role', 'accountStatus', 'createdAt', 'email',
        'coins', 'currentStreak', 'highestStreak', 'totalQuestionsAnswered',
        'correctAnswers', 'practiceSessions', 'proSessions', 'versusMatches',
        'tournamentMatches', 'registrationOrder', 'lastLogin', 'updatedAt',
        'version', 'lastDailyRewardClaim', 'dailyProSessionsPlayed',
        'lastProSessionDate', 'lastRankTransactionId', 'lastXpTransactionId',
        'lastStreakMilestoneCelebrated'
      ];
      for (final field in restrictedPlayerFields) {
        playerProfileMap.remove(field);
      }
      playerProfileMap['updatedAt'] = FieldValue.serverTimestamp();

      transaction.set(
        _firestore.collection('users').doc(userId),
        playerProfileMap,
        SetOptions(merge: true),
      );

      // Public Profile and Leaderboard Sync (if progression exists)
      if (progressionSnapshot.exists) {
        final progression = PlayerProgression.fromJson(progressionSnapshot.data()!);
        
        final publicProfile = PublicCompetitiveProfile(
          userId: userId,
          displayName: userProfile.displayName,
          username: userProfile.username,
          avatarId: userProfile.selectedAvatarId,
          photoUrl: userProfile.avatarUrl,
          currentRank: progression.currentRank,
          rankTier: progression.currentRankTier,
          rankPoints: progression.rankPoints,
          division: _parseDivision(progression.currentRank),
          careerHighlights: CareerStatistics(
            gamesPlayed: playerProfile.gamesPlayed,
            gamesWon: playerProfile.gamesWon,
            gamesLost: playerProfile.gamesPlayed - playerProfile.gamesWon,
            winRate: playerProfile.gamesPlayed > 0 ? playerProfile.gamesWon / playerProfile.gamesPlayed : 0.0,
            totalQuestionsAnswered: playerProfile.totalQuestionsAnswered,
            correctAnswers: playerProfile.correctAnswers,
            accuracy: playerProfile.accuracy,
            currentStreak: playerProfile.currentStreak,
            highestStreak: playerProfile.highestStreak,
            bestRank: 'Unranked',
            peakPosition: 0,
            seasonsPlayed: 0,
          ),
          updatedAt: DateTime.now(),
        );

        final publicProfileMap = PublicProfileDto.toFirestore(publicProfile);
        final restrictedPublicFields = [
          'currentRank', 'rankTier', 'rankPoints', 'division',
          'careerHighlights', 'schemaVersion'
        ];
        for (final field in restrictedPublicFields) {
          publicProfileMap.remove(field);
        }

        transaction.set(
          _firestore.collection('public_profiles').doc(userId),
          publicProfileMap,
          SetOptions(merge: true),
        );

        // 5. Leaderboard Sync
        await _leaderboardRepository.syncLeaderboardEntry(
          profile: playerProfile,
          progression: progression,
          transaction: transaction,
        );
      }
    });
  }

  int _parseDivision(String rankString) {
    if (rankString == 'Unranked' || rankString == 'Elite') return 0;
    final parts = rankString.split(' ');
    if (parts.length < 2) return 0;
    switch (parts[1]) {
      case 'I': return 1;
      case 'II': return 2;
      case 'III': return 3;
      default: return 0;
    }
  }
}
