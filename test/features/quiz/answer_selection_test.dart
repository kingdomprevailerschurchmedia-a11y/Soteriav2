import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/quiz/presentation/providers/quiz_providers.dart';

void main() {
  group('QuizController - Answer Selection', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
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
        await notifier.startQuiz(
          playerId: 'p1',
          mode: GameMode.practice,
          category: 'Science',
          difficulty: Difficulty.easy,
        );

        // state should be updated now because startQuiz was awaited
        final stateBefore = container.read(quizControllerProvider);
        expect(stateBefore.status, equals(QuizStatus.active));
        expect(stateBefore.currentQuestion, isNotNull);

        final future = notifier.selectAnswer('o1');

        // Check state immediately before delay completes
        final stateDuring = container.read(quizControllerProvider);
        expect(stateDuring.selectedOptionId, equals('o1'));
        expect(stateDuring.isAnswerLocked, isTrue);

        await future;
      },
    );

    test(
      'Double-tap protection: second selection is ignored when locked',
      () async {
        final notifier = container.read(quizControllerProvider.notifier);

        await notifier.startQuiz(
          playerId: 'p1',
          mode: GameMode.practice,
          category: 'Science',
          difficulty: Difficulty.easy,
        );

        // First selection
        final firstSelectionFuture = notifier.selectAnswer('o1');

        // Rapid second selection
        await notifier.selectAnswer('o2');

        // Check state before delay completes
        final stateDuring = container.read(quizControllerProvider);
        expect(
          stateDuring.selectedOptionId,
          equals('o1'),
          reason: 'Should remain o1',
        );

        await firstSelectionFuture;
      },
    );
  });
}
