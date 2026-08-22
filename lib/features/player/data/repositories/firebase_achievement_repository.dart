import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/achievement.dart';
import '../../domain/models/xp_transaction.dart';
import '../../domain/repositories/achievement_repository.dart';
import '../../domain/repositories/player_progression_repository.dart';
import '../../domain/services/achievement_registry.dart';
import '../../domain/services/progression_service.dart';
import '../../../../core/logging/logger_service.dart';
import 'package:soteria/features/player/data/repositories/firebase_player_progression_repository.dart';

class FirebaseAchievementRepository implements AchievementRepository {
  final FirebaseFirestore _firestore;
  final PlayerProgressionRepository _progressionRepository;
  final ProgressionService _progressionService;

  FirebaseAchievementRepository(
    this._firestore,
    this._progressionRepository,
    this._progressionService,
  );

  CollectionReference<Map<String, dynamic>> _achievementCollection(
    String userId,
  ) => _firestore.collection('users').doc(userId).collection('achievements');

  @override
  Future<List<AchievementDefinition>> getDefinitions() async {
    return AchievementRegistry.definitions;
  }

  @override
  Stream<List<PlayerAchievement>> watchPlayerAchievements(String userId) {
    return _achievementCollection(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        _sanitizeDate(data, 'unlockedAt');
        _sanitizeDate(data, 'claimedAt');
        return PlayerAchievement.fromJson(data);
      }).toList();
    });
  }

  void _sanitizeDate(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is Timestamp) {
      data[key] = value.toDate().toIso8601String();
    }
  }

  @override
  Future<void> unlockAchievement(String userId, String achievementId) async {
    final definition = AchievementRegistry.getById(achievementId);
    if (definition == null) {
      throw Exception('Achievement definition not found: $achievementId');
    }

    final docRef = _achievementCollection(userId).doc(achievementId);
    final userRef = _firestore.collection('users').doc(userId);
    // Deterministic transaction ID for reward idempotency
    final txId = 'ach_reward_${userId}_$achievementId';

    await _firestore.runTransaction((tx) async {
      final achievementSnapshot = await tx.get(docRef);

      // 1. Idempotency Check for Achievement Document
      if (achievementSnapshot.exists) {
        final current = PlayerAchievement.fromJson(achievementSnapshot.data()!);
        if (current.status == AchievementStatus.unlocked ||
            current.status == AchievementStatus.claimed) {
          return; // Already unlocked
        }
      }

      final now = DateTime.now();
      final playerAchievement = PlayerAchievement(
        userId: userId,
        achievementId: achievementId,
        status: AchievementStatus.unlocked,
        currentValue: definition.threshold,
        targetValue: definition.threshold,
        unlockedAt: now,
      );

      // 3. Save Achievement State
      tx.set(docRef, playerAchievement.toJson());

      // 4. Update User document list (for legacy/easy access)
      tx.update(userRef, {
        'achievements': FieldValue.arrayUnion([achievementId]),
        'updatedAt': now.toIso8601String(),
      });

      // 5. Grant XP Reward if applicable
      if (definition.xpReward > 0) {
        final xpTx = XpTransaction(
          transactionId: txId,
          userId: userId,
          amount: definition.xpReward,
          source: XpSource.achievement,
          referenceId: achievementId,
          createdAt: now,
        );

        if (_progressionRepository is FirebasePlayerProgressionRepository) {
          await (_progressionRepository)
              .processXpTransaction(tx, xpTx);
        } else {
          // Fallback for non-firestore implementations (e.g. mocks in some tests)
          // though usually this repository is used with Firestore.
          LoggerService.w(
            'Progression repository is not FirebasePlayerProgressionRepository. Achievement reward may not be atomic.',
            feature: 'Achievement',
          );
          // We can't safely proceed here if we want atomicity and don't have the firestore transaction hook.
          // But for now, we'll just throw or log.
        }
      }
    });
  }

  @override
  Future<void> claimAchievementReward(String userId, String achievementId) async {
    // Standard logic auto-claims. Future expansion for manual claims can be added here.
  }

  @override
  Future<PlayerAchievement?> getPlayerAchievement(
    String userId,
    String achievementId,
  ) async {
    final doc = await _achievementCollection(userId).doc(achievementId).get();
    if (!doc.exists) return null;
    return PlayerAchievement.fromJson(doc.data()!);
  }
}
