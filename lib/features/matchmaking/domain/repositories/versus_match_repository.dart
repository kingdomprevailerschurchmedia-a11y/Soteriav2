import '../../../gameplay_engine/models/versus_match.dart';

abstract class VersusMatchRepository {
  /// Observes a specific versus match.
  Stream<VersusMatch?> observeMatch(String matchId);

  /// Sets the player as ready in the match.
  Future<void> setReady(String matchId, String userId);

  /// Updates the player's session ID in the match.
  Future<void> updateSessionId(String matchId, String userId, String sessionId);

  /// Abandons the match.
  Future<void> abandonMatch(String matchId, String userId);

  /// Updates the player's current score in the match.
  Future<void> updateScore(String matchId, String userId, int score);

  /// Updates the player's current question progress in the match.
  Future<void> updateProgress(String matchId, String userId, int progress);

  /// Completes the match (client-side intent, server remains authoritative).
  Future<void> completeMatch(String matchId, String userId);
}
