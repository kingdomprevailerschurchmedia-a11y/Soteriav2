import '../models/achievement.dart';

abstract interface class AchievementRepository {
  /// Fetches all achievement definitions from the registry or remote source.
  Future<List<AchievementDefinition>> getDefinitions();

  /// Watches a player's achievement states.
  Stream<List<PlayerAchievement>> watchPlayerAchievements(String userId);

  /// Unlocks an achievement for a user and grants rewards.
  /// Must be idempotent.
  Future<void> unlockAchievement(String userId, String achievementId);

  /// Claims rewards for an unlocked achievement if applicable.
  Future<void> claimAchievementReward(String userId, String achievementId);

  /// Fetches a specific player achievement state.
  Future<PlayerAchievement?> getPlayerAchievement(String userId, String achievementId);
}
