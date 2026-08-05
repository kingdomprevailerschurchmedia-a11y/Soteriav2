import '../../models/game_state.dart';
import '../../models/game_result.dart';

/// Repository interface for managing gameplay sessions and persistence.
abstract interface class GameplayRepository {
  /// Saves the current session state locally.
  Future<void> saveSessionState(GameState state);

  /// Resumes a previously saved session state.
  Future<GameState?> resumeSession(String sessionId);

  /// Synchronizes session metadata with the remote server.
  Future<void> syncSessionMetadata(GameState state);

  /// Records a final game result.
  Future<void> recordGameResult(GameResult result);

  /// Loads the most recent active session if it exists.
  Future<GameState?> getActiveSession();

  /// Clears the active session state.
  Future<void> clearActiveSession();
}
