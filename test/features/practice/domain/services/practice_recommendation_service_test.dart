import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/practice/domain/models/practice_result.dart';
import 'package:soteria/features/practice/domain/services/practice_recommendation_service.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

void main() {
  group('PracticeRecommendationService', () {
    test('should recommend weak area if detected', () {
      final result = PracticeResult(
        sessionId: 'test',
        userId: 'test_user',
        completedAt: DateTime.now(),
        totalQuestions: 10,
        answeredQuestions: 10,
        correctAnswers: 5,
        incorrectAnswers: 5,
        skippedQuestions: 0,
        accuracy: 0.5,
        score: 250,
        totalTime: const Duration(minutes: 5),
        categoryPerformance: {
          'science': const CategoryPerformance(
            categoryId: 'science',
            total: 5,
            correct: 1,
            accuracy: 0.2,
          ),
        },
        difficultyPerformance: {},
        reviewItems: [
          const QuestionReviewItem(
            questionId: 'q1',
            questionText: 'Q1',
            selectedOptionIds: [],
            correctOptionIds: [],
            isCorrect: false,
            isSkipped: false,
            categoryId: 'science',
            difficulty: Difficulty.medium,
            responseTime: Duration.zero,
          ),
        ],
        insights: [
          const LearningInsight(
            title: 'Weakness',
            description: 'SCIENCE could use practice',
            type: LearningInsightType.weakness,
            isPositive: false,
          ),
        ],
      );

      final rec = PracticeRecommendationService.recommendNext(result);
      
      expect(rec?.categoryId, 'science');
      expect(rec?.title, contains('Weak Area'));
    });

    test('should recommend higher difficulty on mastery', () {
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
        categoryPerformance: {},
        difficultyPerformance: {},
        reviewItems: [
          const QuestionReviewItem(
            questionId: 'q1',
            questionText: 'Q1',
            selectedOptionIds: [],
            correctOptionIds: [],
            isCorrect: true,
            isSkipped: false,
            categoryId: 'science',
            difficulty: Difficulty.medium,
            responseTime: Duration.zero,
          ),
        ],
        insights: [],
      );

      final rec = PracticeRecommendationService.recommendNext(result);
      
      expect(rec?.difficulty, Difficulty.hard);
      expect(rec?.title, contains('Level Up'));
    });
  });
}
