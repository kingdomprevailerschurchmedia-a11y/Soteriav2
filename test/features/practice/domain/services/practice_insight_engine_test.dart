import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/practice/domain/models/practice_result.dart';
import 'package:soteria/features/practice/domain/services/practice_insight_engine.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

void main() {
  group('PracticeInsightEngine', () {
    test('should detect strong category with enough samples', () {
      final result = PracticeResult(
        sessionId: 'test',
        userId: 'test_user',
        completedAt: DateTime.now(),
        totalQuestions: 5,
        answeredQuestions: 5,
        correctAnswers: 5,
        incorrectAnswers: 0,
        skippedQuestions: 0,
        accuracy: 1.0,
        score: 500,
        totalTime: const Duration(minutes: 1),
        categoryPerformance: {
          'science': const CategoryPerformance(
            categoryId: 'science',
            total: 5,
            correct: 5,
            accuracy: 1.0,
          ),
        },
        difficultyPerformance: {Difficulty.easy: 1.0},
        reviewItems: [],
      );

      final insights = PracticeInsightEngine.generateInsights(result);
      
      final strength = insights.firstWhere((i) => i.type == LearningInsightType.strength);
      expect(strength.description, contains('SCIENCE'));
    });

    test('should NOT detect weakness with small sample size', () {
      final result = PracticeResult(
        sessionId: 'test',
        userId: 'test_user',
        completedAt: DateTime.now(),
        totalQuestions: 5,
        answeredQuestions: 1,
        correctAnswers: 0,
        incorrectAnswers: 1,
        skippedQuestions: 4,
        accuracy: 0.0,
        score: 0,
        totalTime: const Duration(minutes: 1),
        categoryPerformance: {
          'tech': const CategoryPerformance(
            categoryId: 'tech',
            total: 1,
            correct: 0,
            accuracy: 0.0,
          ),
        },
        difficultyPerformance: {Difficulty.medium: 0.0},
        reviewItems: [],
      );

      final insights = PracticeInsightEngine.generateInsights(result);
      
      expect(insights.any((i) => i.type == LearningInsightType.weakness), isFalse);
    });

    test('should detect improvement from history', () {
      final current = PracticeResult(
        sessionId: 'current',
        userId: 'test_user',
        completedAt: DateTime.now(),
        totalQuestions: 5,
        answeredQuestions: 5,
        correctAnswers: 4,
        incorrectAnswers: 1,
        skippedQuestions: 0,
        accuracy: 0.8,
        score: 400,
        totalTime: const Duration(minutes: 1),
        categoryPerformance: {},
        difficultyPerformance: {},
        reviewItems: [],
      );

      final history = [
        GameResult(
          sessionId: 'prev',
          mode: GameMode.practice,
          finalScore: 100,
          totalXP: 20,
          totalQuestions: 5,
          correctAnswers: 2,
          wrongAnswers: 3,
          totalDuration: const Duration(minutes: 1),
          accuracy: 0.4,
          maxStreak: 2,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

      final insights = PracticeInsightEngine.generateInsights(current, history: history);
      
      final improvement = insights.firstWhere((i) => i.type == LearningInsightType.improvement);
      expect(improvement.description, contains('40%'));
    });
  });
}
