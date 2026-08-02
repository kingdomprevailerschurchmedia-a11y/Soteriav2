import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import '../../helpers/gameplay_integration_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Gameplay Stress Tests', () {
    final config = GameplayIntegrationHarness.createTestConfig();
    final questions = GameplayIntegrationHarness.generateMockQuestions(5);

    test(
      'Run 5 consecutive game sessions without state corruption',
      () async {
        final container = ProviderContainer();

        for (int i = 0; i < 5; i++) {
          final engine = container.read(gameEngineProvider(config).notifier);
          await engine.startSession(questions);

          for (int q = 0; q < 5; q++) {
            engine.submitAnswer(['a']);
            // Wait for auto-advance (1500ms + buffer)
            await Future.delayed(const Duration(milliseconds: 1700));
          }

          expect(
            container.read(gameEngineProvider(config)).lifecycle,
            GameLifecycle.completed,
          );
        }

        container.dispose();
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );
  });
}
