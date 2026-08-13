import '../models/matchmaking_session.dart';

abstract class MatchmakingRepository {
  /// Enters the matchmaking queue with the given configuration.
  Future<MatchmakingSession> enterQueue({
    required Map<String, dynamic> configuration,
    required Map<String, dynamic> rankSnapshot,
  });

  /// Cancels the current matchmaking session.
  Future<void> cancelQueue(String sessionId);

  /// Confirms readiness for a found match.
  Future<void> confirmMatch(String sessionId);

  /// Observes the matchmaking session for updates.
  Stream<MatchmakingSession?> observeSession(String sessionId);

  /// Checks if the player is already in an active queue.
  Future<MatchmakingSession?> getActiveSession();
}
