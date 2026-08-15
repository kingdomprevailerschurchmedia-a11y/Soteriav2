import '../models/goal.dart';

abstract interface class GoalRepository {
  /// Watches all active goals for a user.
  Stream<List<PlayerGoal>> watchActiveGoals(String userId);

  /// Fetches historical goals for a user.
  Future<List<PlayerGoal>> getGoalHistory(String userId, {int limit = 50});

  /// Updates the state of a goal (progress, status).
  Future<void> updateGoalProgress(PlayerGoal goal);

  /// Generates or fetches initial goals for a new period (day/week).
  Future<List<PlayerGoal>> refreshGoals(String userId);

  /// Creates a new goal for a user.
  Future<void> createGoal(PlayerGoal goal);

  /// Deletes a goal.
  Future<void> deleteGoal(String userId, String goalId);
}
