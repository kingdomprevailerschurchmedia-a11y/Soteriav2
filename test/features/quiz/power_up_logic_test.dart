import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/quiz/presentation/controllers/quiz_controller.dart';
import 'package:soteria/features/quiz/presentation/providers/quiz_providers.dart';

void main() {
  group('QuizController - Power-Ups', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() => container.dispose());

    Future<void> setupQuiz() async {
      final notifier = container.read(quizControllerProvider.notifier);
      await notifier.startQuiz(
        playerId: 'p1',
        mode: GameMode.practice,
        category: 'Science',
        difficulty: Difficulty.easy,
      );
      // Mock loading delay from MockQuizRemoteDataSource (1s + 1s)
      await Future.delayed(const Duration(milliseconds: 2500));
    }

    test('50/50 removes exactly two incorrect options', () async {
      await setupQuiz();
      final notifier = container.read(quizControllerProvider.notifier);

      await notifier.activatePowerUp(PowerUpType.fiftyFifty);

      final state = container.read(quizControllerProvider);
      expect(state.hiddenOptionIds.length, equals(2));
      expect(
        state.hiddenOptionIds.contains('o1'),
        isFalse,
        reason: 'Correct answer should never be hidden',
      );

      final powerUp = state.powerUps.firstWhere(
        (p) => p.type == PowerUpType.fiftyFifty,
      );
      expect(powerUp.status, equals(PowerUpStatus.used));
      expect(powerUp.remainingUses, equals(0));
    });

    test('50/50 cannot be used twice in same round', () async {
      await setupQuiz();
      final notifier = container.read(quizControllerProvider.notifier);

      await notifier.activatePowerUp(PowerUpType.fiftyFifty);

      // Try using it again
      await notifier.activatePowerUp(PowerUpType.fiftyFifty);

      final state = container.read(quizControllerProvider);
      final powerUp = state.powerUps.firstWhere(
        (p) => p.type == PowerUpType.fiftyFifty,
      );
      expect(powerUp.usageHistory.length, equals(1));
    });

    test('Pause Timer pauses main timer and starts power-up timer', () async {
      await setupQuiz();
      final notifier = container.read(quizControllerProvider.notifier);

      await notifier.activatePowerUp(PowerUpType.pauseTimer);

      final state = container.read(quizControllerProvider);
      expect(state.timer?.isRunning, isFalse);
      expect(state.powerUpTimer?.isRunning, isTrue);
      expect(state.powerUpTimer?.totalDuration.inSeconds, equals(10));

      final powerUp = state.powerUps.firstWhere(
        (p) => p.type == PowerUpType.pauseTimer,
      );
      expect(powerUp.status, equals(PowerUpStatus.used));
    });

    test('Ask Audience generates distribution totaling 100%', () async {
      await setupQuiz();
      final notifier = container.read(quizControllerProvider.notifier);

      await notifier.activatePowerUp(PowerUpType.askAudience);

      final state = container.read(quizControllerProvider);
      expect(state.audienceDistribution.isNotEmpty, isTrue);

      double total = state.audienceDistribution.values.fold(0, (a, b) => a + b);
      expect(total, closeTo(1.0, 0.0001));

      final powerUp = state.powerUps.firstWhere(
        (p) => p.type == PowerUpType.askAudience,
      );
      expect(powerUp.status, equals(PowerUpStatus.used));
    });

    test(
      'Power-ups effects are cleared on next question but usage remains',
      () async {
        await setupQuiz();
        final notifier = container.read(quizControllerProvider.notifier);

        await notifier.activatePowerUp(PowerUpType.fiftyFifty);

        // Select answer to proceed to next question
        await notifier.selectAnswer('o1');
        // Delay for feedback (1.5s)
        await Future.delayed(const Duration(milliseconds: 2000));

        final state = container.read(quizControllerProvider);
        expect(state.hiddenOptionIds.isEmpty, isTrue);
        expect(state.currentIndex, equals(1));

        final powerUp = state.powerUps.firstWhere(
          (p) => p.type == PowerUpType.fiftyFifty,
        );
        expect(
          powerUp.status,
          equals(PowerUpStatus.used),
          reason: 'Power-up should remain used for the round',
        );
      },
    );
  });
}
