import '../../models/quiz_result.dart';
import '../../repositories/quiz_history_repository.dart';

class PerformanceSummary {
  final int totalQuizzes;
  final double averageAccuracy;
  final int averageScore;
  final int bestScore;
  final double bestAccuracy;
  final int bestStreak;
  final int totalXp;
  final Duration averageResponseTime;

  PerformanceSummary({
    required this.totalQuizzes,
    required this.averageAccuracy,
    required this.averageScore,
    required this.bestScore,
    required this.bestAccuracy,
    required this.bestStreak,
    required this.totalXp,
    required this.averageResponseTime,
  });

  factory PerformanceSummary.empty() => PerformanceSummary(
    totalQuizzes: 0,
    averageAccuracy: 0.0,
    averageScore: 0,
    bestScore: 0,
    bestAccuracy: 0.0,
    bestStreak: 0,
    totalXp: 0,
    averageResponseTime: Duration.zero,
  );
}

class GetPerformanceSummaryUseCase {
  final QuizHistoryRepository _repository;

  GetPerformanceSummaryUseCase(this._repository);

  Future<PerformanceSummary> execute(String playerId) async {
    final results = await _repository.getResults(playerId);
    if (results.isEmpty) return PerformanceSummary.empty();

    int totalScore = 0;
    double totalAccuracy = 0;
    int bestScore = 0;
    double bestAccuracy = 0;
    int bestStreak = 0;
    int totalXp = 0;
    int totalMillis = 0;

    for (final result in results) {
      totalScore += result.finalScore.toInt();
      totalAccuracy += result.accuracy.toDouble();
      totalXp += result.xpEarned.toInt();
      totalMillis += result.averageResponseTime.inMilliseconds;

      if (result.finalScore > bestScore) bestScore = result.finalScore.toInt();
      if (result.accuracy > bestAccuracy) bestAccuracy = result.accuracy.toDouble();
      if (result.longestStreak > bestStreak) bestStreak = result.longestStreak.toInt();
    }

    return PerformanceSummary(
      totalQuizzes: results.length,
      averageAccuracy: totalAccuracy / results.length,
      averageScore: (totalScore / results.length).round(),
      bestScore: bestScore,
      bestAccuracy: bestAccuracy,
      bestStreak: bestStreak,
      totalXp: totalXp,
      averageResponseTime: Duration(
        milliseconds: (totalMillis / results.length).round(),
      ),
    );
  }
}
