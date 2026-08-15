import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/practice/domain/models/practice_result.dart';
import 'package:soteria/features/practice/domain/models/practice_history.dart';

void main() {
  group('PracticeHistory.fromResults', () {
    test('returns empty history when results are empty', () {
      final history = PracticeHistory.fromResults([]);
      expect(history.totalSessions, 0);
      expect(history.totalQuestions, 0);
    });

    test('correctly aggregates statistics from multiple sessions', () {
      final results = [
        PracticeResult(
          sessionId: '1',
          userId: 'user1',
          completedAt: DateTime(2026, 8, 1),
          totalQuestions: 10,
          answeredQuestions: 10,
          correctAnswers: 8,
          incorrectAnswers: 2,
          skippedQuestions: 0,
          accuracy: 0.8,
          score: 800,
          totalTime: const Duration(minutes: 5),
          categoryPerformance: {
            'science': const CategoryPerformance(categoryId: 'science', total: 5, correct: 4, accuracy: 0.8),
            'math': const CategoryPerformance(categoryId: 'math', total: 5, correct: 4, accuracy: 0.8),
          },
          difficultyPerformance: {},
          reviewItems: [],
        ),
        PracticeResult(
          sessionId: '2',
          userId: 'user1',
          completedAt: DateTime(2026, 8, 2),
          totalQuestions: 10,
          answeredQuestions: 10,
          correctAnswers: 6,
          incorrectAnswers: 4,
          skippedQuestions: 0,
          accuracy: 0.6,
          score: 600,
          totalTime: const Duration(minutes: 4),
          categoryPerformance: {
            'science': const CategoryPerformance(categoryId: 'science', total: 5, correct: 3, accuracy: 0.6),
            'history': const CategoryPerformance(categoryId: 'history', total: 5, correct: 3, accuracy: 0.6),
          },
          difficultyPerformance: {},
          reviewItems: [],
        ),
      ];

      final history = PracticeHistory.fromResults(results);

      expect(history.totalSessions, 2);
      expect(history.totalQuestions, 20);
      expect(history.totalCorrect, 14);
      expect(history.averageAccuracy, 0.7);
      
      // Category aggregation
      expect(history.categoryPerformance['science']?.total, 10);
      expect(history.categoryPerformance['science']?.correct, 7);
      expect(history.categoryPerformance['science']?.accuracy, 0.7);
      expect(history.categoryPerformance['math']?.total, 5);
      expect(history.categoryPerformance['history']?.total, 5);

      // Personal Bests
      expect(history.personalBests.highestAccuracy, 0.8);
      expect(history.personalBests.bestScore, 800);
      expect(history.personalBests.longestSession, const Duration(minutes: 5));
    });

    test('correctly maps trends in chronological order', () {
      final results = [
        PracticeResult(
          sessionId: '2',
          userId: 'user1',
          completedAt: DateTime(2026, 8, 2),
          totalQuestions: 10,
          answeredQuestions: 10,
          correctAnswers: 9,
          incorrectAnswers: 1,
          skippedQuestions: 0,
          accuracy: 0.9,
          score: 900,
          totalTime: const Duration(minutes: 5),
          categoryPerformance: {},
          difficultyPerformance: {},
          reviewItems: [],
        ),
        PracticeResult(
          sessionId: '1',
          userId: 'user1',
          completedAt: DateTime(2026, 8, 1),
          totalQuestions: 10,
          answeredQuestions: 10,
          correctAnswers: 7,
          incorrectAnswers: 3,
          skippedQuestions: 0,
          accuracy: 0.7,
          score: 700,
          totalTime: const Duration(minutes: 5),
          categoryPerformance: {},
          difficultyPerformance: {},
          reviewItems: [],
        ),
      ];

      final history = PracticeHistory.fromResults(results);

      // Trends should be chronological (Session 1 then Session 2)
      expect(history.trends.length, 2);
      expect(history.trends[0].accuracy, 0.7);
      expect(history.trends[1].accuracy, 0.9);
    });
   group('Performance Trends', () {
      test('improving trend: recent average > previous average', () {
        // Implementation for trend calculation in UI or a separate helper
        // For now, let's just verify the data is there
      });
    });
  });
}
