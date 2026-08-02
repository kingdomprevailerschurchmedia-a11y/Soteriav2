import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';
import '../../helpers/gameplay_integration_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Gameplay Integration E2E Tests', () {
    late ProviderContainer container;
    final config = GameplayIntegrationHarness.createTestConfig();
    final questions = GameplayIntegrationHarness.generateMockQuestions(3);

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Complete Gameplay Loop: 3 Correct Answers', () async {
      final engine = container.read(gameEngineProvider(config).notifier);

      // 1. Start Session
      await engine.startSession(questions);
      expect(
        container.read(gameEngineProvider(config)).lifecycle,
        GameLifecycle.playing,
      );
      expect(container.read(timerEngineProvider).status, TimerStatus.running);

      // 2. Question 1
      engine.submitAnswer(['a']); // Correct
      expect(
        container.read(gameEngineProvider(config)).lifecycle,
        GameLifecycle.answered,
      );
      expect(container.read(scoreProvider), greaterThan(0));

      // Wait for auto-advance
      await Future.delayed(const Duration(milliseconds: 1600));
      expect(
        container.read(gameEngineProvider(config)).currentQuestionIndex,
        1,
      );

      // 3. Question 2
      engine.submitAnswer(['a']); // Correct
      await Future.delayed(const Duration(milliseconds: 1600));
      expect(
        container.read(gameEngineProvider(config)).currentQuestionIndex,
        2,
      );

      // 4. Question 3
      engine.submitAnswer(['a']); // Correct
      await Future.delayed(const Duration(milliseconds: 1600));

      // 5. Game Completion
      expect(
        container.read(gameEngineProvider(config)).lifecycle,
        GameLifecycle.completed,
      );
      expect(container.read(streakProvider), 3);
    });

    test('Streak Reset on Wrong Answer', () async {
      final engine = container.read(gameEngineProvider(config).notifier);
      await engine.startSession(questions);

      // Correct Q1
      engine.submitAnswer(['a']);
      await Future.delayed(const Duration(milliseconds: 1600));
      expect(container.read(streakProvider), 1);

      // Wrong Q2
      engine.submitAnswer(['b']);
      expect(container.read(streakProvider), 0);
    });

    test('Timeout handling', () async {
      final engine = container.read(gameEngineProvider(config).notifier);
      await engine.startSession(questions);

      // Manually trigger timer expiration
      container.read(timerEngineProvider.notifier).reset();
      container
          .read(timerEngineProvider.notifier)
          .start(const Duration(milliseconds: 10));

      await Future.delayed(const Duration(milliseconds: 200));

      expect(
        container.read(gameEngineProvider(config)).lifecycle,
        GameLifecycle.timeout,
      );
      expect(container.read(streakProvider), 0);
    });
  });
}
