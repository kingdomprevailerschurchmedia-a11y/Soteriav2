import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/providers/gameplay_providers.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';

class MockGameplayRepository implements GameplayRepository {
  @override
  Future<void> saveSessionState(GameState state) async {}
  @override
  Future<GameState?> resumeSession(String sessionId) async => null;
  @override
  Future<void> syncSessionMetadata(GameState state) async {}
  @override
  Future<void> recordGameResult(GameResult result) async {}
  @override
  Future<GameState?> getActiveSession() async => null;
  @override
  Future<void> clearActiveSession() async {}
  @override
  Future<List<GameResult>> getRecentResults(String uid, {GameMode? mode, int limit = 10}) async => [];
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Pro Mode Gameplay Logic', () {
    late GameConfiguration proConfig;
    late MockGameplayRepository mockRepo;
    
    setUp(() {
      proConfig = const GameConfiguration(
        mode: GameMode.pro,
        questionCount: 10,
        initialLives: 3,
      );
      mockRepo = MockGameplayRepository();
    });

    test('Engine starts with locked session questions', () async {
      final container = ProviderContainer(
        overrides: [
          gameplayRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      final questions = MockDataFactory.createMockQuestions(10);
      
      final engine = container.read(gameEngineProvider(proConfig).notifier);
      await engine.startSession(questions);
      
      final state = container.read(gameEngineProvider(proConfig));
      expect(state.questions.length, 10);
      expect(state.questions.first.id, questions.first.id);
      expect(state.lifecycle, GameLifecycle.playing);
    });

    test('Answering correctly advances index and updates score', () async {
      final container = ProviderContainer(
        overrides: [
          gameplayRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      final questions = MockDataFactory.createMockQuestions(2);
      
      final engine = container.read(gameEngineProvider(proConfig).notifier);
      await engine.startSession(questions);
      
      // Submit correct answer for first question
      engine.submitAnswer([questions.first.correctOptionIds.first]);
      
      var state = container.read(gameEngineProvider(proConfig));
      expect(state.lifecycle, GameLifecycle.answered);
      
      // Advance manually (simulating auto-advance or manual next)
      engine.moveToNextQuestion();
      
      state = container.read(gameEngineProvider(proConfig));
      expect(state.currentQuestionIndex, 1);
      expect(state.lifecycle, GameLifecycle.playing);
    });

    test('Losing all lives ends session with failed state', () async {
      final container = ProviderContainer(
        overrides: [
          gameplayRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      final questions = MockDataFactory.createMockQuestions(5);
      
      final engine = container.read(gameEngineProvider(proConfig).notifier);
      await engine.startSession(questions);
      
      // Submit 3 wrong answers
      engine.submitAnswer(['wrong']);
      engine.moveToNextQuestion();
      engine.submitAnswer(['wrong']);
      engine.moveToNextQuestion();
      engine.submitAnswer(['wrong']); // 3rd strike
      
      final state = container.read(gameEngineProvider(proConfig));
      expect(state.lifecycle, GameLifecycle.failed);
      expect(state.lives, 0);
    });
  });
}
