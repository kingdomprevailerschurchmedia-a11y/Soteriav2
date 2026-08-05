import '../../models/game_result.dart';

/// Repository for handling post-game logic and synchronization.
abstract interface class PostGameRepository {
  /// Synchronizes session progress and grants rewards atomically.
  Future<void> syncProgress(GameResult result);

  /// Unlocks achievements based on session performance.
  Future<List<String>> unlockAchievements(GameResult result);

  /// Saves the final session summary for historical review.
  Future<void> saveSessionSummary(GameResult result);

  /// Retrieves the sync queue for offline sessions.
  Future<List<GameResult>> getOfflineSyncQueue();

  /// Removes a session from the sync queue after successful synchronization.
  Future<void> removeFromSyncQueue(String sessionId);

  /// Adds a session to the offline sync queue.
  Future<void> addToSyncQueue(GameResult result);
}
