import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/daily_engagement.dart';
import '../../domain/models/player_progression.dart';
import '../../domain/repositories/engagement_repository.dart';
import '../../domain/services/engagement_service.dart';
import '../../domain/services/progression_service.dart';

class FirebaseEngagementRepository implements EngagementRepository {
  final FirebaseFirestore _firestore;
  final EngagementService _engagementService;

  FirebaseEngagementRepository(
    this._firestore, {
    EngagementService? engagementService,
  }) : _engagementService = engagementService ?? EngagementService();

  @override
  Future<int> recordEngagement({
    required String userId,
    required String activityType,
    required String activityId,
    required String timezone,
  }) async {
    final now = DateTime.now();
    final engagementDate = _engagementService.getEngagementDate(now, timezone);

    final engagementDoc = _firestore
        .collection('users')
        .doc(userId)
        .collection('daily_engagement')
        .doc(engagementDate);

    return await _firestore.runTransaction((transaction) async {
      final engagementSnapshot = await transaction.get(engagementDoc);

      // 1. Idempotency Check
      if (engagementSnapshot.exists) {
        final progDoc = await transaction.get(
          _firestore.collection('player_progression').doc(userId),
        );
        return progDoc.data()?['dailyStreak'] ?? 0;
      }

      // 2. Fetch current progression
      final progressionDoc = _firestore.collection('player_progression').doc(userId);
      final progressionSnapshot = await transaction.get(progressionDoc);

      PlayerProgression progression;
      if (!progressionSnapshot.exists) {
        progression = PlayerProgression.initial(userId, 'current_season');
      } else {
        progression = PlayerProgression.fromJson(progressionSnapshot.data()!);
      }

      // 3. Calculate new streak
      int newStreak = 1;
      final lastDate = progression.lastEngagementDate;

      if (lastDate != null) {
        if (_engagementService.isSameDay(lastDate, engagementDate)) {
          return progression.dailyStreak;
        } else if (_engagementService.isConsecutive(lastDate, engagementDate)) {
          newStreak = progression.dailyStreak + 1;
        } else {
          newStreak = 1;
        }
      }

      final newLongestStreak =
          newStreak > progression.longestStreak
              ? newStreak
              : progression.longestStreak;

      // 4. Update Progression
      final updatedProgression = progression.copyWith(
        dailyStreak: newStreak,
        longestStreak: newLongestStreak,
        lastEngagementDate: engagementDate,
        lastUpdated: now,
      );

      // 5. Create Engagement Record
      final dailyEngagement = DailyEngagement(
        playerId: userId,
        engagementDate: engagementDate,
        qualifyingActivityType: activityType,
        qualifyingActivityId: activityId,
        firstQualifiedActivityAt: now,
        createdAt: now,
      );

      transaction.set(progressionDoc, updatedProgression.toJson());
      transaction.set(engagementDoc, dailyEngagement.toJson());

      // 6. Update user_game_profiles for sync
      transaction.set(
        _firestore.collection('user_game_profiles').doc(userId),
        {
          'dailyStreak': newStreak,
          'longestStreak': newLongestStreak,
          'lastEngagementDate': engagementDate,
          'updatedAt': now,
        },
        SetOptions(merge: true),
      );

      return newStreak;
    });
  }

  @override
  Stream<List<DailyEngagement>> watchEngagements(
    String userId, {
    required DateTime start,
    required DateTime end,
  }) {
    final startStr = _engagementService.getEngagementDate(start, 'UTC');
    final endStr = _engagementService.getEngagementDate(end, 'UTC');

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('daily_engagement')
        .where('engagementDate', isGreaterThanOrEqualTo: startStr)
        .where('engagementDate', isLessThanOrEqualTo: endStr)
        .orderBy('engagementDate', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => DailyEngagement.fromJson(doc.data()))
              .toList();
        });
  }

  @override
  Future<DailyEngagement?> getTodayEngagement(String userId, String timezone) async {
    final dateStr = _engagementService.getEngagementDate(DateTime.now(), timezone);
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('daily_engagement')
        .doc(dateStr)
        .get();

    if (!doc.exists) return null;
    return DailyEngagement.fromJson(doc.data()!);
  }
}
