import '../../domain/models/quiz_session.dart';
import '../../domain/models/quiz_result.dart';

abstract class QuizLocalDataSource {
  Future<void> saveProgress(QuizSession session);
  Future<QuizSession?> loadProgress(String sessionId);
  Future<void> clearProgress(String sessionId);
  Future<void> clearAllProgress(String playerId);

  // History
  Future<void> saveResult(QuizResult result);
  Future<QuizResult?> getResult(String sessionId);
  Future<List<QuizResult>> getResults(String playerId);
  Future<void> deleteResult(String sessionId);
  Future<void> clearHistory(String playerId);
}
