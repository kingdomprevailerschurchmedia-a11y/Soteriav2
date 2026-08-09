import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/quiz/domain/models/question.dart';
import 'package:soteria/features/quiz/domain/models/answer_option.dart';
import 'package:soteria/features/quiz/presentation/controllers/quiz_controller.dart';
import 'package:soteria/features/quiz/presentation/providers/quiz_providers.dart';
import 'package:soteria/features/quiz/data/repository/mock_question_repository.dart';

void main() {
  group('QuizController - Answer Selection', () {
    late ProviderContainer container;

    final mockQuestion = Question(
      id: 'q1',
      type: QuestionType.multipleChoice,
      category: 'Science',
      difficulty: Difficulty.easy,
      text: 'Test Question',
      options: [
        const AnswerOption(id: 'o1', text: 'A'),
        const AnswerOption(id: 'o2', text: 'B'),
      ],
      correctOptionIds: ['o1'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    setUp(() {
      container = ProviderContainer(
        overrides: [
          // Override repository to avoid real firebase calls if necessary
          // Though we focus on controller logic here
        ],
      );
    });

    tearDown(() => container.dispose());

    test('Initial state has no selection and is not locked', () {
      final state = container.read(quizControllerProvider);
      expect(state.selectedOptionId, isNull);
      expect(state.isAnswerLocked, isFalse);
    });

    test(
      'Selecting an answer locks the state and sets selectedOptionId',
      () async {
        final notifier = container.read(quizControllerProvider.notifier);

        // Setup state with questions
        notifier.startQuiz(
          playerId: 'p1',
          mode: GameMode.practice,
          category: 'Science',
          difficulty: Difficulty.easy,
        );

        // Wait for loading to finish (mock repo delay)
        await Future.delayed(const Duration(milliseconds: 600));

        await notifier.selectAnswer('o1');

        final state = container.read(quizControllerProvider);
        expect(state.selectedOptionId, equals('o1'));
        expect(state.isAnswerLocked, isTrue);
      },
    );

    test(
      'Double-tap protection: second selection is ignored when locked',
      () async {
        final notifier = container.read(quizControllerProvider.notifier);

        notifier.startQuiz(
          playerId: 'p1',
          mode: GameMode.practice,
          category: 'Science',
          difficulty: Difficulty.easy,
        );
        await Future.delayed(const Duration(milliseconds: 600));

        // First selection
        final firstSelectionFuture = notifier.selectAnswer('o1');

        // Rapid second selection
        await notifier.selectAnswer('o2');

        await firstSelectionFuture;

        final state = container.read(quizControllerProvider);
        expect(
          state.selectedOptionId,
          equals('o1'),
          reason: 'Should remain o1',
        );
      },
    );
  });
}
