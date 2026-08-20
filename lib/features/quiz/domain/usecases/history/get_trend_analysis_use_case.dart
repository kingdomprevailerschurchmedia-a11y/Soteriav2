import '../../repositories/quiz_history_repository.dart';

class PerformanceTrendPoint {
  final DateTime date;
  final double value;

  PerformanceTrendPoint(this.date, this.value);
}

enum TrendType { accuracy, score, xp, streak }

class GetTrendAnalysisUseCase {
  final QuizHistoryRepository _repository;

  GetTrendAnalysisUseCase(this._repository);

  Future<List<PerformanceTrendPoint>> execute(
    String playerId, {
    required TrendType type,
    int days = 30,
  }) async {
    final start = DateTime.now().subtract(Duration(days: days));
    final end = DateTime.now();

    final results = await _repository.getResultsByDateRange(
      playerId,
      start,
      end,
    );

    // Sort by date ascending for trends
    results.sort((a, b) => a.completedAt.compareTo(b.completedAt));

    return results.map((r) {
      double value;
      switch (type) {
        case TrendType.accuracy:
          value = r.accuracy;
          break;
        case TrendType.score:
          value = r.finalScore.toDouble();
          break;
        case TrendType.xp:
          value = r.xpEarned.toDouble();
          break;
        case TrendType.streak:
          value = r.longestStreak.toDouble();
          break;
      }
      return PerformanceTrendPoint(r.completedAt, value);
    }).toList();
  }
}
