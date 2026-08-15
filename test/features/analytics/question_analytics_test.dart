import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/analytics/domain/models/question_analytics.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

void main() {
  group('QuestionAnalytics', () {
    test('accuracyRate is calculated correctly', () {
      const analytics = QuestionAnalytics(
        questionId: 'q1',
        version: '1.0.0',
        categoryId: 'cat1',
        difficulty: Difficulty.medium,
        totalAttempts: 100,
        correctAttempts: 75,
        incorrectAttempts: 25,
      );

      expect(analytics.accuracyRate, 0.75);
    });

    test('accuracyRate handles zero attempts safely', () {
      const analytics = QuestionAnalytics(
        questionId: 'q1',
        version: '1.0.0',
        categoryId: 'cat1',
        difficulty: Difficulty.medium,
        totalAttempts: 0,
        correctAttempts: 0,
        incorrectAttempts: 0,
      );

      expect(analytics.accuracyRate, 0.0);
    });

    test('timeoutRate is calculated correctly', () {
      const analytics = QuestionAnalytics(
        questionId: 'q1',
        version: '1.0.0',
        categoryId: 'cat1',
        difficulty: Difficulty.medium,
        totalAttempts: 100,
        timeoutCount: 10,
      );

      expect(analytics.timeoutRate, 0.1);
    });

    test('getAttemptsForMode returns correct value', () {
      const analytics = QuestionAnalytics(
        questionId: 'q1',
        version: '1.0.0',
        categoryId: 'cat1',
        difficulty: Difficulty.medium,
        modeBreakdown: {
          'practice': 80,
          'pro': 20,
        },
      );

      expect(analytics.getAttemptsForMode(GameMode.practice), 80);
      expect(analytics.getAttemptsForMode(GameMode.pro), 20);
      expect(analytics.getAttemptsForMode(GameMode.tournament), 0);
    });

    test('serialization preserves values', () {
      final analytics = QuestionAnalytics(
        questionId: 'q1',
        version: '1.0.0',
        categoryId: 'cat1',
        difficulty: Difficulty.hard,
        totalAttempts: 10,
        averageResponseTime: const Duration(seconds: 5),
        lastAttemptAt: DateTime(2023, 1, 1),
      );

      final json = analytics.toJson();
      final fromJson = QuestionAnalytics.fromJson(json);

      expect(fromJson.questionId, 'q1');
      expect(fromJson.difficulty, Difficulty.hard);
      expect(fromJson.averageResponseTime, const Duration(seconds: 5));
      expect(fromJson.lastAttemptAt, DateTime(2023, 1, 1));
    });
  });
}
