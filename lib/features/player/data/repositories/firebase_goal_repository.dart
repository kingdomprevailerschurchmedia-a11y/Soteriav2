import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_goal.dart';
import '../../domain/repositories/goal_repository.dart';

class FirebaseGoalRepository implements GoalRepository {
  final FirebaseFirestore _firestore;

  FirebaseGoalRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _goalsCollection(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('competitive_goals');

  @override
  Stream<List<CompetitiveGoal>> watchActiveGoals(String userId) {
    // Only active or recently completed goals
    return _goalsCollection(userId)
        .where('status', whereIn: ['active', 'completed'])
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => CompetitiveGoal.fromJson(doc.data()))
              .toList();
        });
  }

  @override
  Future<List<CompetitiveGoal>> getGoalHistory(
    String userId, {
    int limit = 50,
  }) async {
    final snapshot = await _goalsCollection(
      userId,
    ).orderBy('endAt', descending: true).limit(limit).get();

    return snapshot.docs
        .map((doc) => CompetitiveGoal.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> updateGoalProgress(CompetitiveGoal goal) async {
    await _goalsCollection(goal.userId).doc(goal.id).set(goal.toJson());
  }

  @override
  Future<void> createGoal(CompetitiveGoal goal) async {
    await _goalsCollection(goal.userId).doc(goal.id).set(goal.toJson());
  }

  @override
  Future<void> deleteGoal(String userId, String goalId) async {
    await _goalsCollection(userId).doc(goalId).delete();
  }

  @override
  Future<List<CompetitiveGoal>> refreshGoals(String userId) async {
    // In a real app, this would be a server-side generation via Cloud Functions
    // For this Story, we'll return a deterministic set of goals if none exist for today.

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    // Simple check for today's goals
    final snapshot = await _goalsCollection(userId)
        .where('type', isEqualTo: 'daily')
        .where(
          'startAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart),
        )
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs
          .map((doc) => CompetitiveGoal.fromJson(doc.data()))
          .toList();
    }

    // Generate deterministic daily goals
    final newGoals = [
      CompetitiveGoal(
        id: 'daily_games_${todayStart.millisecondsSinceEpoch}',
        userId: userId,
        type: GoalType.daily,
        category: GoalCategory.gameCount,
        title: 'Daily Participation',
        description: 'Play 3 competitive games today.',
        target: 3,
        currentProgress: 0,
        status: GoalStatus.active,
        startAt: todayStart,
        endAt: todayEnd,
      ),
      CompetitiveGoal(
        id: 'daily_wins_${todayStart.millisecondsSinceEpoch}',
        userId: userId,
        type: GoalType.daily,
        category: GoalCategory.win,
        title: 'Winning Streak',
        description: 'Win 2 competitive games today.',
        target: 2,
        currentProgress: 0,
        status: GoalStatus.active,
        startAt: todayStart,
        endAt: todayEnd,
      ),
    ];

    for (final goal in newGoals) {
      await _goalsCollection(userId).doc(goal.id).set(goal.toJson());
    }

    return newGoals;
  }
}
