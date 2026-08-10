import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/analytics/data/repositories/analytics_aggregator.dart';
import 'package:soteria/features/analytics/domain/models/analytics_enums.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

void main() {
  group('AnalyticsAggregator Tests', () {
    final mockResult1 = QuizResult(
      sessionId: 's1',
      playerId: 'p1',
      gameMode: GameMode.practice,
      category: 'Science',
      difficulty: Difficulty.easy,
      totalQuestions: 10,
      answeredQuestions: 10,
      correctAnswers: 8,
      wrongAnswers: 2,
      skipped: 0,
      timedOut: 0,
      accuracy: 0.8,
      finalScore: 800,
      xpEarned: 100,
      longestStreak: 5,
      finalStreak: 3,
      averageResponseTime: const Duration(seconds: 5),
      fastestResponseTime: const Duration(seconds: 2),
      slowestResponseTime: const Duration(seconds: 10),
      questionResults: [],
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
      completionTime: const Duration(minutes: 1),
      performanceRating: 'Excellent',
    );

    final mockResult2 = QuizResult(
      sessionId: 's2',
      playerId: 'p1',
      gameMode: GameMode.practice,
      category: 'Science',
      difficulty: Difficulty.medium,
      totalQuestions: 10,
      answeredQuestions: 10,
      correctAnswers: 9,
      wrongAnswers: 1,
      skipped: 0,
      timedOut: 0,
      accuracy: 0.9,
      finalScore: 1000,
      xpEarned: 150,
      longestStreak: 8,
      finalStreak: 5,
      averageResponseTime: const Duration(seconds: 4),
      fastestResponseTime: const Duration(seconds: 1),
      slowestResponseTime: const Duration(seconds: 8),
      questionResults: [],
      completedAt: DateTime.now(),
      completionTime: const Duration(minutes: 1),
      performanceRating: 'Master',
    );

    test('Aggregate basic stats correctly', () {
      final analytics = AnalyticsAggregator.aggregate(
        playerId: 'p1',
        period: TimePeriod.last30Days,
        currentResults: [mockResult1, mockResult2],
        previousResults: [],
      );

      expect(analytics.totalQuizzes, 2);
      expect(analytics.totalQuestions, 20);
      expect(analytics.averageAccuracy, closeTo(0.85, 0.001));
      expect(analytics.averageScore, 900);
      expect(analytics.totalXp, 250);
      expect(analytics.averageResponseTime.inMilliseconds, 4500);
    });

    test('Aggregate category performance correctly', () {
      final analytics = AnalyticsAggregator.aggregate(
        playerId: 'p1',
        period: TimePeriod.last30Days,
        currentResults: [mockResult1, mockResult2],
        previousResults: [],
      );

      expect(analytics.categoryPerformance.length, 1);
      expect(analytics.categoryPerformance.first.category, 'Science');
      expect(analytics.categoryPerformance.first.accuracy, closeTo(0.85, 0.001));
    });
  });
}
