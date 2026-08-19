import '../../models/game_state.dart';
import '../../models/game_result.dart';

abstract interface class CompetitiveRepository {
  Future<void> submitCompetitiveAnswer(String sessionId, dynamic answer);
  Future<void> startCompetitiveSession(String sessionId);
  Future<void> updateSessionCheckpoint(String sessionId, GameState state);
  Future<bool> validateCheckpoint(String sessionId, String checkpointId);
  Future<void> completeCompetitiveSession(String sessionId, GameResult result);
}
