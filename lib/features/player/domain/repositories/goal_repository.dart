import '../models/competitive_goal.dart';

abstract interface class GoalRepository {
  /// Watches all active goals for a user.
  Stream<List<CompetitiveGoal>> watchActiveGoals(String userId);

  /// Fetches historical goals for a user.
  Future<List<CompetitiveGoal>> getGoalHistory(String userId, {int limit = 50});

  /// Updates the state of a goal (progress, status).
  Future<void> updateGoalProgress(CompetitiveGoal goal);

  /// Generates or fetches initial goals for a new period (day/week).
  Future<List<CompetitiveGoal>> refreshGoals(String userId);

  /// Creates a new goal for a user.
  Future<void> createGoal(CompetitiveGoal goal);

  /// Deletes a goal.
  Future<void> deleteGoal(String userId, String goalId);
}
