import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/gameplay_engine/providers/pro_mode_results_provider.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/pro_mode_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/pro_mode_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/dashboard/presentation/providers/pro_lobby_providers.dart';

@GenerateMocks([ProModeRepository])
import 'pro_mode_results_integration_test.mocks.dart';

void main() {
  late MockProModeRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockProModeRepository();
    container = ProviderContainer(
      overrides: [
        proModeRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('Pro Mode Results Integration Tests', () {
    test('completeSession calls repository and updates state with authoritative result', () async {
      final gameState = GameState(
        playerId: 'test-player',
      sessionId: 'session-123',
        lifecycle: GameLifecycle.completed,
        questions: [],
        answerHistory: [],
      );

      final expectedResult = ProModeResult(
        playerId: 'test-player',
      sessionId: 'session-123',
        mode: GameMode.pro,
        finalScore: 1000,
        totalXP: 100,
        totalQuestions: 0,
        correctAnswers: 0,
        wrongAnswers: 0,
        totalDuration: Duration.zero,
        accuracy: 1.0,
        maxStreak: 0,
        timestamp: DateTime.now(),
        rating: 'S',
      );

      when(mockRepository.completeSession(any, any))
          .thenAnswer((_) async => expectedResult);

      final notifier = container.read(proModeResultsProvider.notifier);
      await notifier.completeSession(gameState);

      final state = container.read(proModeResultsProvider);
      expect(state.result.value, equals(expectedResult));
      verify(mockRepository.completeSession('session-123', gameState)).called(1);
    });

    test('loadResult fetches result from repository', () async {
      final expectedResult = ProModeResult(
        playerId: 'test-player',
      sessionId: 'session-123',
        mode: GameMode.pro,
        finalScore: 1000,
        totalXP: 100,
        totalQuestions: 0,
        correctAnswers: 0,
        wrongAnswers: 0,
        totalDuration: Duration.zero,
        accuracy: 1.0,
        maxStreak: 0,
        timestamp: DateTime.now(),
        rating: 'S',
      );

      when(mockRepository.getResult('session-123'))
          .thenAnswer((_) async => expectedResult);

      final notifier = container.read(proModeResultsProvider.notifier);
      await notifier.loadResult('session-123');

      final state = container.read(proModeResultsProvider);
      expect(state.result.value, equals(expectedResult));
    });

    test('loadResult handles error when result not found', () async {
      when(mockRepository.getResult('session-missing'))
          .thenAnswer((_) async => null);

      final notifier = container.read(proModeResultsProvider.notifier);
      await notifier.loadResult('session-missing');

      final state = container.read(proModeResultsProvider);
      expect(state.result.hasError, isTrue);
    });
  });
}
