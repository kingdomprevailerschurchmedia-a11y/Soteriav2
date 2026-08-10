import '../../domain/models/quiz_enums.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/repositories/quiz_history_repository.dart';
import '../datasource/quiz_local_data_source.dart';

class QuizHistoryRepositoryImpl implements QuizHistoryRepository {
  final QuizLocalDataSource _localDataSource;

  QuizHistoryRepositoryImpl(this._localDataSource);

  @override
  Future<void> addResult(QuizResult result) async {
    // Ensure immutability by adding createdAt if not present
    final entry = result.createdAt == null
        ? result.copyWith(createdAt: DateTime.now())
        : result;
    await _localDataSource.saveResult(entry);
  }

  @override
  Future<QuizResult?> getResult(String sessionId) {
    return _localDataSource.getResult(sessionId);
  }

  @override
  Future<List<QuizResult>> getResults(String playerId) async {
    final results = await _localDataSource.getResults(playerId);
    // Sort by completedAt descending by default
    results.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return results;
  }

  @override
  Future<List<QuizResult>> getRecentResults(String playerId, {int limit = 10}) async {
    final results = await getResults(playerId);
    return results.take(limit).toList();
  }

  @override
  Future<List<QuizResult>> getResultsByMode(String playerId, GameMode mode) async {
    final results = await getResults(playerId);
    return results.where((r) => r.gameMode == mode).toList();
  }

  @override
  Future<List<QuizResult>> getResultsByCategory(String playerId, String category) async {
    final results = await getResults(playerId);
    return results.where((r) => r.category == category).toList();
  }

  @override
  Future<List<QuizResult>> getResultsByDifficulty(String playerId, Difficulty difficulty) async {
    final results = await getResults(playerId);
    return results.where((r) => r.difficulty == difficulty).toList();
  }

  @override
  Future<List<QuizResult>> getResultsByDateRange(String playerId, DateTime start, DateTime end) async {
    final results = await getResults(playerId);
    return results.where((r) => 
      r.completedAt.isAfter(start) && r.completedAt.isBefore(end)
    ).toList();
  }

  @override
  Future<List<QuizResult>> getBestResults(String playerId, {int limit = 5}) async {
    final results = await getResults(playerId);
    results.sort((a, b) => b.finalScore.compareTo(a.finalScore));
    return results.take(limit).toList();
  }

  @override
  Future<QuizResult?> getLatestResult(String playerId) async {
    final results = await getResults(playerId);
    return results.isNotEmpty ? results.first : null;
  }

  @override
  Future<int> getTotalCompleted(String playerId) async {
    final results = await _localDataSource.getResults(playerId);
    return results.length;
  }

  @override
  Future<void> deleteResult(String sessionId) {
    return _localDataSource.deleteResult(sessionId);
  }

  @override
  Future<void> clearHistory(String playerId) {
    return _localDataSource.clearHistory(playerId);
  }
}
