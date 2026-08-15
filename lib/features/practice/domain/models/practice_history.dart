import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../question_content/domain/entities/difficulty.dart';
import 'practice_result.dart';

part 'practice_history.freezed.dart';
part 'practice_history.g.dart';

@freezed
abstract class PracticeHistory with _$PracticeHistory {
  const factory PracticeHistory({
    required int totalSessions,
    required int totalQuestions,
    required int totalCorrect,
    required double averageAccuracy,
    required Map<String, CategoryPerformance> categoryPerformance,
    required Map<Difficulty, double> difficultyPerformance,
    required List<PracticeTrendPoint> trends,
    required PersonalBests personalBests,
    required List<PracticeResult> recentSessions,
  }) = _PracticeHistory;

  factory PracticeHistory.fromJson(Map<String, dynamic> json) => _$PracticeHistoryFromJson(json);

  factory PracticeHistory.empty() => const PracticeHistory(
    totalSessions: 0,
    totalQuestions: 0,
    totalCorrect: 0,
    averageAccuracy: 0.0,
    categoryPerformance: {},
    difficultyPerformance: {},
    trends: [],
    personalBests: PersonalBests(
      highestAccuracy: 0.0,
      mostQuestionsInSession: 0,
      bestScore: 0,
      longestSession: Duration.zero,
    ),
    recentSessions: [],
  );

  factory PracticeHistory.fromResults(List<PracticeResult> results) {
    if (results.isEmpty) return PracticeHistory.empty();

    int totalQuestions = 0;
    int totalCorrect = 0;
    double totalAccuracy = 0;
    final Map<String, int> catCounts = {};
    final Map<String, int> catCorrect = {};

    for (final res in results) {
      totalQuestions += res.totalQuestions;
      totalCorrect += res.correctAnswers;
      totalAccuracy += res.accuracy;

      res.categoryPerformance.forEach((catId, perf) {
        catCounts[catId] = (catCounts[catId] ?? 0) + perf.total;
        catCorrect[catId] = (catCorrect[catId] ?? 0) + perf.correct;
      });
    }

    final categoryPerformance = catCounts.map((catId, total) {
      final correct = catCorrect[catId] ?? 0;
      return MapEntry(
        catId,
        CategoryPerformance(
          categoryId: catId,
          total: total,
          correct: correct,
          accuracy: total > 0 ? correct / total : 0.0,
        ),
      );
    });

    return PracticeHistory(
      totalSessions: results.length,
      totalQuestions: totalQuestions,
      totalCorrect: totalCorrect,
      averageAccuracy: totalAccuracy / results.length,
      categoryPerformance: categoryPerformance,
      difficultyPerformance: {}, // Simplified
      trends: results.reversed.map((res) => PracticeTrendPoint(
        timestamp: res.completedAt,
        accuracy: res.accuracy,
      )).toList(),
      personalBests: PersonalBests(
        highestAccuracy: results.map((r) => r.accuracy).fold(0.0, (max, v) => v > max ? v : max),
        mostQuestionsInSession: results.map((r) => r.totalQuestions).fold(0, (max, v) => v > max ? v : max),
        bestScore: results.map((r) => r.score).fold(0, (max, v) => v > max ? v : max),
        longestSession: results.map((r) => r.totalTime).fold(Duration.zero, (max, v) => v > max ? v : max),
      ),
      recentSessions: results,
    );
  }
}

@freezed
abstract class PracticeTrendPoint with _$PracticeTrendPoint {
  const factory PracticeTrendPoint({
    required DateTime timestamp,
    required double accuracy,
  }) = _PracticeTrendPoint;

  factory PracticeTrendPoint.fromJson(Map<String, dynamic> json) => _$PracticeTrendPointFromJson(json);
}

@freezed
abstract class PersonalBests with _$PersonalBests {
  const factory PersonalBests({
    required double highestAccuracy,
    required int mostQuestionsInSession,
    required int bestScore,
    required Duration longestSession,
  }) = _PersonalBests;

  factory PersonalBests.fromJson(Map<String, dynamic> json) => _$PersonalBestsFromJson(json);
}

enum PerformanceTrendState { improving, stable, declining, insufficientData }
