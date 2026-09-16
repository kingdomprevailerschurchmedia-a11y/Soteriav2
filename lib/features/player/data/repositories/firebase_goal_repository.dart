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
        .where('status', whereIn: ['active', 'completed', 'claimed'])
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
    
    // 1. Calculate Time Windows
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));
    
    // Weekly window (assuming Monday start)
    final daysToMonday = now.weekday - DateTime.monday;
    final weekStart = todayStart.subtract(Duration(days: daysToMonday));
    final weekEnd = weekStart.add(const Duration(days: 7));

    // 2. Fetch all current period goals
    final snapshot = await _goalsCollection(userId)
        .where('expiresAt', isGreaterThan: Timestamp.fromDate(now))
        .get();

    final existingGoals = snapshot.docs
        .map((doc) => PlayerGoal.fromJson(doc.data()))
        .toList();

    final List<PlayerGoal> generatedGoals = [];

    // 3. Check & Generate Daily Goals
    final dailyDefinitions = GoalRegistry.getByType(GoalType.daily);
    for (final def in dailyDefinitions) {
      final exists = existingGoals.any((g) => 
        g.goalId == def.id && 
        g.startedAt.isAtSameMomentAs(todayStart)
      );
      
      if (!exists) {
        final newGoal = PlayerGoal(
          userId: userId,
          goalId: def.id,
          status: GoalStatus.active,
          currentProgress: 0,
          startedAt: todayStart,
          expiresAt: todayEnd,
        );
        await createGoal(newGoal);
        generatedGoals.add(newGoal);
      }
    }

    // 4. Check & Generate Weekly Goals
    final weeklyDefinitions = GoalRegistry.getByType(GoalType.weekly);
    for (final def in weeklyDefinitions) {
      final exists = existingGoals.any((g) => 
        g.goalId == def.id && 
        g.startedAt.isAtSameMomentAs(weekStart)
      );
      
      if (!exists) {
        final newGoal = PlayerGoal(
          userId: userId,
          goalId: def.id,
          status: GoalStatus.active,
          currentProgress: 0,
          startedAt: weekStart,
          expiresAt: weekEnd,
        );
        await createGoal(newGoal);
        generatedGoals.add(newGoal);
      }
    }

    return [...existingGoals, ...generatedGoals];
  }
}
