import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/dashboard/presentation/screens/pro_gameplay_screen.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_session.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';

class ProGameplayPreviews {
  static Widget active() {
    final session = _createMockSession();
    return ProGameplayScreen(session: session);
  }

  static Widget midSession() {
    final session = _createMockSession();
    final config = _createGameConfig(session);
    
    return ProviderScope(
      overrides: [
        gameEngineProvider(config).overrideWith((ref) => _FakeGameEngine(
          config,
          _createMidState(session),
        )),
      ],
      child: ProGameplayScreen(session: session),
    );
  }

  static Widget finalQuestion() {
    final session = _createMockSession();
    final config = _createGameConfig(session);
    
    return ProviderScope(
      overrides: [
        gameEngineProvider(config).overrideWith((ref) => _FakeGameEngine(
          config,
          _createFinalState(session),
        )),
      ],
      child: ProGameplayScreen(session: session),
    );
  }

  static Widget timerCritical() {
    final session = _createMockSession();
    final config = _createGameConfig(session);
    
    return ProviderScope(
      overrides: [
        gameEngineProvider(config).overrideWith((ref) => _FakeGameEngine(
          config,
          _createMidState(session).copyWith(
            lifecycle: GameLifecycle.playing,
            // Mocking timer state via Engine is harder without affecting the actual TimerEngine provider
            // but we can at least show the playing state.
          ),
        )),
      ],
      child: ProGameplayScreen(session: session),
    );
  }

  static Widget answeredCorrect() {
    final session = _createMockSession();
    final config = _createGameConfig(session);
    
    return ProviderScope(
      overrides: [
        gameEngineProvider(config).overrideWith((ref) => _FakeGameEngine(
          config,
          _createMidState(session).copyWith(
            lifecycle: GameLifecycle.answered,
          ),
        )),
      ],
      child: ProGameplayScreen(session: session),
    );
  }

  static CompetitiveSession _createMockSession() {
    return MockDataFactory.createMockCompetitiveSession(
      id: 'pro_preview_session',
      fee: 250,
      difficulty: 'expert',
    );
  }

  static GameConfiguration _createGameConfig(CompetitiveSession session) {
    return GameConfiguration(
      mode: GameMode.pro,
      questionCount: session.config.questionCount,
      questionTimer: const Duration(seconds: 15),
      allowLifelines: true,
      difficultyMultiplier: 2.0,
      categoryId: session.config.category?.id,
      metadata: {'reservedFee': session.reservedFee},
    );
  }

  static GameState _createMidState(CompetitiveSession session) {
    return GameState(
      playerId: 'mock-player-id',
      sessionId: session.sessionId,
      lifecycle: GameLifecycle.playing,
      questions: session.questions,
      currentQuestionIndex: 4,
      score: 400,
      streak: 4,
      lives: 3,
      startTime: DateTime.now().subtract(const Duration(minutes: 2)),
    );
  }

  static GameState _createFinalState(CompetitiveSession session) {
    return GameState(
      playerId: 'mock-player-id',
      sessionId: session.sessionId,
      lifecycle: GameLifecycle.playing,
      questions: session.questions,
      currentQuestionIndex: 9,
      score: 800,
      streak: 2,
      lives: 1,
      startTime: DateTime.now().subtract(const Duration(minutes: 5)),
    );
  }
}

class _FakeGameEngine extends GameEngine {
  final GameState _mockState;

  _FakeGameEngine(GameConfiguration config, this._mockState)
    : super(config: config) {
    state = _mockState;
  }

  @override
  GameState get state => _mockState;

  @override
  GameState get debugState => _mockState;

  @override
  Future<void> startSession(List<Question> questions, {String? sessionId}) async {
    state = _mockState;
  }

  @override
  void submitAnswer(List<String> selectedOptionIds) {}
}
