import '../../models/competitive_session.dart';
import '../../models/game_state.dart';
import '../../models/pro_mode_result.dart';
import '../../../question_content/domain/entities/difficulty.dart';

abstract interface class ProModeRepository {
  Future<bool> validateEntry(String uid, Difficulty difficulty);
  Future<void> reserveEntryFee(String uid, String sessionId, Difficulty difficulty, {bool isFree = false});
  Future<void> createCompetitiveSession(CompetitiveSession session);
  Future<int> getAvailableQuestionCount({
    List<String>? categoryIds,
    required Difficulty difficulty,
  });
  Future<ProModeResult> completeSession(String sessionId, GameState finalState);
  Future<ProModeResult?> getResult(String sessionId);
  Future<void> refundEntryFee(String uid, String sessionId, Difficulty difficulty);
}
