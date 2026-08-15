import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/goal.dart';
import '../../domain/repositories/goal_repository.dart';
import '../../domain/config/goal_registry.dart';

class FirebaseGoalRepository implements GoalRepository {
  final FirebaseFirestore _firestore;

  FirebaseGoalRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _goalsCollection(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('competitive_goals');

  @override
  Stream<List<PlayerGoal>> watchActiveGoals(String userId) {
    return _goalsCollection(userId)
        .where('status', whereIn: ['active', 'completed'])
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => PlayerGoal.fromJson(doc.data()))
              .toList();
        });
  }

  @override
  Future<List<PlayerGoal>> getGoalHistory(
    String userId, {
    int limit = 50,
  }) async {
    final snapshot = await _goalsCollection(
      userId,
    ).orderBy('expiresAt', descending: true).limit(limit).get();

    return snapshot.docs
        .map((doc) => PlayerGoal.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> updateGoalProgress(PlayerGoal goal) async {
    await _goalsCollection(goal.userId).doc(playerGoalId(goal.goalId, goal.startedAt)).set(goal.toJson());
  }
  
  String playerGoalId(String definitionId, DateTime startedAt) {
    return '${definitionId}_${startedAt.millisecondsSinceEpoch}';
  }

  @override
  Future<void> createGoal(PlayerGoal goal) async {
    await _goalsCollection(goal.userId).doc(playerGoalId(goal.goalId, goal.startedAt)).set(goal.toJson());
  }

  @override
  Future<void> deleteGoal(String userId, String goalId) async {
    await _goalsCollection(userId).doc(goalId).delete();
  }

  @override
  Future<List<PlayerGoal>> refreshGoals(String userId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    // Simple check for today's daily goals
    final snapshot = await _goalsCollection(userId)
        .where('startedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
        .where('startedAt', isLessThan: Timestamp.fromDate(todayEnd))
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs
          .map((doc) => PlayerGoal.fromJson(doc.data()))
          .toList();
    }

    // Generate daily goals from registry
    final dailyDefinitions = GoalRegistry.getByType(GoalType.daily);
    final newGoals = dailyDefinitions.map((def) => PlayerGoal(
      userId: userId,
      goalId: def.id,
      status: GoalStatus.active,
      currentProgress: 0,
      startedAt: todayStart,
      expiresAt: todayEnd,
    )).toList();

    for (final goal in newGoals) {
      await createGoal(goal);
    }

    return newGoals;
  }
}
