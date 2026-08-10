import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/quiz/domain/models/question_result.dart';
import 'package:soteria/features/quiz/presentation/providers/quiz_providers.dart';

void main() {
  group('QuizResults Logic Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() => container.dispose());

    test('finalizeQuiz produces correct metrics for perfect score', () async {
      final notifier = container.read(quizControllerProvider.notifier);

      await notifier.startQuiz(
        playerId: 'p1',
        mode: GameMode.practice,
        category: 'Science',
        difficulty: Difficulty.easy,
      );

      // Mock questions from MockQuizRemoteDataSource are 2
      // Wait for load
      await Future.delayed(const Duration(milliseconds: 2500));

      // Answer all correctly
      await notifier.selectAnswer('o1'); // q1 correct
      await Future.delayed(const Duration(milliseconds: 2000));
      await notifier.selectAnswer('o1'); // q2 correct
      await Future.delayed(const Duration(milliseconds: 2000));

      final result = await notifier.finalizeQuiz();

      expect(result.correctAnswers, equals(2));
      expect(result.accuracy, equals(1.0));
      expect(result.performanceRating, equals('Exceptional'));
      expect(result.questionResults.every((r) => r.outcome == QuestionOutcome.correct), isTrue);
    });

    test('finalizeQuiz handles mixed results correctly', () async {
      final notifier = container.read(quizControllerProvider.notifier);

      await notifier.startQuiz(
        playerId: 'p1',
        mode: GameMode.practice,
        category: 'Science',
        difficulty: Difficulty.easy,
      );

      await Future.delayed(const Duration(milliseconds: 2500));

      await notifier.selectAnswer('o1'); // q1 correct
      await Future.delayed(const Duration(milliseconds: 2000));
      await notifier.selectAnswer('o2'); // q2 incorrect
      await Future.delayed(const Duration(milliseconds: 2000));

      final result = await notifier.finalizeQuiz();

      expect(result.correctAnswers, equals(1));
      expect(result.wrongAnswers, equals(1));
      expect(result.accuracy, equals(0.5));
      expect(result.questionResults[0].outcome, equals(QuestionOutcome.correct));
      expect(result.questionResults[1].outcome, equals(QuestionOutcome.incorrect));
    });

    test('finalizeQuiz is idempotent', () async {
      final notifier = container.read(quizControllerProvider.notifier);

      await notifier.startQuiz(
        playerId: 'p1',
        mode: GameMode.practice,
        category: 'Science',
        difficulty: Difficulty.easy,
      );

      await Future.delayed(const Duration(milliseconds: 2500));
      await notifier.selectAnswer('o1');
      await Future.delayed(const Duration(milliseconds: 2000));
      await notifier.selectAnswer('o1');
      await Future.delayed(const Duration(milliseconds: 2000));

      final result1 = await notifier.finalizeQuiz();
      final result2 = await notifier.finalizeQuiz();

      expect(result1, same(result2));
    });
  });
}
