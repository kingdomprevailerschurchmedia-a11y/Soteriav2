import '../models/quiz_enums.dart';
import '../models/quiz_result.dart';

abstract class QuizHistoryRepository {
  Future<void> addResult(QuizResult result);
  Future<QuizResult?> getResult(String sessionId);
  Future<List<QuizResult>> getResults(String playerId);
  Future<List<QuizResult>> getRecentResults(String playerId, {int limit = 10});
  Future<List<QuizResult>> getResultsByMode(String playerId, GameMode mode);
  Future<List<QuizResult>> getResultsByCategory(
    String playerId,
    String category,
  );
  Future<List<QuizResult>> getResultsByDifficulty(
    String playerId,
    Difficulty difficulty,
  );
  Future<List<QuizResult>> getResultsByDateRange(
    String playerId,
    DateTime start,
    DateTime end,
  );
  Future<List<QuizResult>> getBestResults(String playerId, {int limit = 5});
  Future<QuizResult?> getLatestResult(String playerId);
  Future<int> getTotalCompleted(String playerId);
  Future<void> deleteResult(String sessionId);
  Future<void> clearHistory(String playerId);
}
