import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_submission.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_policy.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_processor.dart';
import 'package:soteria/features/gameplay_engine/answer/providers/answer_processor_provider.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_state.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/lifelines/providers/lifeline_controller.dart';
import 'package:soteria/features/gameplay_engine/lifelines/providers/lifeline_results_provider.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_policy.dart';
import 'package:soteria/features/gameplay_engine/integrity/providers/integrity_providers.dart';
import 'package:soteria/features/gameplay_engine/integrity/models/integrity_signal.dart';
import 'package:soteria/features/question_presentation/providers/presentation_providers.dart';
import 'package:soteria/core/logging/logger_service.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/providers/gameplay_providers.dart';
import 'package:soteria/features/gameplay_engine/providers/competitive_gameplay_providers.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart' as player_prog;
import 'package:soteria/core/identity/providers/identity_providers.dart';

/// Central engine managing the lifecycle and state of a gameplay session.
class GameEngine extends StateNotifier<GameState> {
  final GameConfiguration config;
  final AnalyticsHook? analytics;
  final AnswerProcessor? _answerProcessor;
  final TimerEngine? _timerEngine;
  final ProgressionNotifier? _progression;
  final IntegrityNotifier? _integrity;
  final GameplayRepository? _repository;
  final Ref? ref;

  StreamSubscription<TimerState>? _timerSubscription;

  GameEngine({
    required this.config,
    this.analytics,
    AnswerProcessor? answerProcessor,
    TimerEngine? timerEngine,
    ProgressionNotifier? progression,
    IntegrityNotifier? integrity,
    GameplayRepository? repository,
    this.ref,
  }) : _answerProcessor = answerProcessor,
       _timerEngine = timerEngine,
       _progression = progression,
       _integrity = integrity,
       _repository = repository,
       super(
         GameState(
           sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
           playerId: ref?.read(currentPlayerProvider)?.uid ?? 'unknown',
         ),
       ) {
    _subscribeToTimer();
  }

  void _subscribeToTimer() {
    _timerSubscription = _timerEngine?.stream.listen((timerState) {
      if (timerState.status == TimerStatus.expired &&
          state.lifecycle == GameLifecycle.playing) {
        _handleTimeout();
      }
    });
  }

  void _handleTimeout() {
    state = state.copyWith(lifecycle: GameLifecycle.timeout);

    // Reveal the correct answer in UI
    ref?.read(isResultRevealedProvider.notifier).state = true;

    final result = AnswerResult(
      submissionId: 'timeout_${DateTime.now().millisecondsSinceEpoch}',
      questionId: state.currentQuestion?.id ?? 'unknown',
      decision: AnswerDecision.wrong, // Timeout counts as wrong
      correctOptionIds: state.currentQuestion?.correctOptionIds ?? [],
      timestamp: DateTime.now(),
      questionVersion: state.currentQuestion?.version,
      metadata: {'timeout': true},
    );

    _handleAnswerResult(result);

    // Show explanation after a delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        ref?.read(showExplanationProvider.notifier).state = true;
      }
    });
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }

  void setLifelineController(LifelineController controller) {
    // Hook for future usage tracking
  }

  /// Helper for testing to access protected state.
  @override
  GameState get debugState => state;

  /// Starts the game session.
  Future<void> startSession(List<Question> questions, {String? sessionId}) async {
    try {
      state = state.copyWith(
        lifecycle: GameLifecycle.loading,
        questions: questions,
        sessionId: sessionId,
      );

      // Initialize Integrity Monitoring
      _integrity?.startSession(state.sessionId, config.mode);

      // Authoritative remote start for competitive modes
      if (config.mode == GameMode.pro) {
        await ref
            ?.read(competitiveRepositoryProvider)
            .startCompetitiveSession(state.sessionId);
      }

      // Hydrate progression baseline from authoritative record
      final authoritativeProg =
          ref?.read(player_prog.competitiveProgressionProvider).value;
      if (authoritativeProg != null) {
        _progression?.hydrate(
          ProgressSnapshot.fromProgression(authoritativeProg),
        );
      } else {
        _progression?.resetSession();
      }

      // Simulate preparation time for loading animations
      await Future.delayed(const Duration(milliseconds: 800));

      state = state.copyWith(
        lifecycle: GameLifecycle.playing,
        startTime: DateTime.now(),
        lives: config.initialLives,
      );

      _startQuestionTimer();

      analytics?.trackEvent('Game Started', {'mode': config.mode.name});
      _saveCheckpoint();
    } catch (e, st) {
      LoggerService.e('Game session initialization failed', error: e, stackTrace: st);
      state = state.copyWith(lifecycle: GameLifecycle.failed);
    }
  }

  /// Hydrates the engine with a previously saved state (for session resume).
  void hydrate(GameState hydratedState) {
    state = hydratedState;
    if (state.lifecycle == GameLifecycle.playing) {
      _startQuestionTimer();
    }
  }

  void _startQuestionTimer() {
    final effectiveDuration = config.questionTimer ??
        state.currentQuestion?.estimatedTime ??
        const Duration(seconds: 30);

    _timerEngine?.start(effectiveDuration);
  }

  void _saveCheckpoint() {
    _repository?.saveSessionState(state);
  }

  /// Handles user answer submission through the Answer Engine.
  void submitAnswer(List<String> selectedOptionIds) {
    if (state.lifecycle != GameLifecycle.playing) return;
    if (state.currentQuestion == null) return;

    final submission = AnswerSubmission(
      questionId: state.currentQuestion!.id,
      selectedOptionIds: selectedOptionIds,
      timestamp: DateTime.now(),
      responseTime: DateTime.now().difference(
        state.lastAnswerTime ?? state.startTime!,
      ),
    );

    // Stop timer immediately on submission to lock response time and prevent late submissions
    _timerEngine?.pause(reason: 'answered');

    final policy = AnswerPolicyResolver.resolve(config.mode);
    final timerStatus = _timerEngine?.debugState.status ?? TimerStatus.running;

    final result = _answerProcessor?.process(
      submission: submission,
      question: state.currentQuestion!,
      lifecycle: state.lifecycle,
      timerStatus: timerStatus,
      policy: policy,
      alreadySubmitted: state.lifecycle == GameLifecycle.answered,
    );

    if (result != null) {
      // Check for suspicious timing
      if (submission.responseTime.inMilliseconds < 500) {
        _integrity?.reportManualSignal(
          IntegritySignalType.tooFastAnswer,
          metadata: {'responseTimeMs': submission.responseTime.inMilliseconds},
        );
      }

      _handleAnswerResult(result);
      _saveCheckpoint();
    }
  }

  void _handleAnswerResult(AnswerResult result) {
    final progressionPolicy = ProgressionPolicyResolver.resolve(
      config.mode,
      difficultyMultiplier: config.difficultyMultiplier,
    );
    final careerContext =
        ref?.read(currentPlayerProvider)?.toCareerContext() ?? const {};

    // Record in history for Answer Review
    state = state.copyWith(answerHistory: [...state.answerHistory, result]);

    // Delegate to the Progression Engine
    _progression?.handleAnswer(
      result,
      progressionPolicy,
      careerContext: careerContext,
    );

    if (result.isCorrect) {
      state = state.copyWith(
        score: _progression?.state.sessionScore ?? state.score,
        streak: _progression?.state.sessionStreak ?? state.streak,
        xp: _progression?.state.totalXP ?? state.xp,
        lastAnswerTime: DateTime.now(),
        lifecycle: state.lifecycle == GameLifecycle.timeout
            ? GameLifecycle.timeout
            : GameLifecycle.answered,
      );
    } else {
      final newLives = state.lives - 1;
      state = state.copyWith(
        streak: 0,
        lives: newLives,
        lastAnswerTime: DateTime.now(),
        lifecycle: state.lifecycle == GameLifecycle.timeout
            ? GameLifecycle.timeout
            : GameLifecycle.answered,
      );

      if (newLives <= 0) {
        _endSession(GameLifecycle.failed);
        return;
      }
    }

    // Auto-advance after delay if configured (Story 3.1 logic)
    if (config.autoAdvance) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted && (state.lifecycle == GameLifecycle.answered || state.lifecycle == GameLifecycle.timeout)) {
          moveToNextQuestion();
        }
      });
    }
  }

  void moveToNextQuestion() {
    // Reset UI state for the next question
    ref?.read(answerSelectionProvider.notifier).reset();
    ref?.read(isResultRevealedProvider.notifier).state = false;
    ref?.read(showExplanationProvider.notifier).state = false;
    ref?.read(lifelineResultsProvider.notifier).reset();

    if (state.currentQuestionIndex + 1 >= state.questions.length) {
      _endSession(GameLifecycle.completed);
    } else {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        lifecycle: GameLifecycle.playing,
      );

      _startQuestionTimer();
      _saveCheckpoint();
    }
  }

  void pauseSession() {
    if (state.lifecycle == GameLifecycle.playing) {
      state = state.copyWith(lifecycle: GameLifecycle.paused);
      analytics?.trackEvent('Game Paused', {});
    }
  }

  void resumeSession() {
    if (state.lifecycle == GameLifecycle.paused) {
      state = state.copyWith(lifecycle: GameLifecycle.playing);
      analytics?.trackEvent('Game Resumed', {});
    }
  }

  void cancelSession() {
    _endSession(GameLifecycle.cancelled);
    analytics?.trackEvent('Game Quit', {});
  }

  void _endSession(GameLifecycle finalLifecycle) {
    state = state.copyWith(lifecycle: finalLifecycle);
    _timerEngine?.reset();
    _integrity?.endSession();

    if (finalLifecycle == GameLifecycle.completed) {
      final progressionPolicy = ProgressionPolicyResolver.resolve(
        config.mode,
        difficultyMultiplier: config.difficultyMultiplier,
      );
      final careerContext =
          ref?.read(currentPlayerProvider)?.toCareerContext() ?? const {};

      final correctCount =
          state.score ~/
          100; // This is a bit loose now, but keeping for compatibility
      
      final timezone = ref?.read(profileProvider)?.timezone ?? 'Africa/Lagos';

      _progression?.handleRoundEnd(
        userId: state.playerId,
        sessionId: state.sessionId,
        totalQuestions: state.questions.length,
        correctAnswers: correctCount,
        policy: progressionPolicy,
        timezone: timezone,
        careerContext: careerContext,
      );
    }

    final result = GameResult(
      sessionId: state.sessionId,
      playerId: state.playerId,
      mode: config.mode,
      finalScore: state.score,
      totalXP: _progression?.state.totalXP ?? state.xp,
      totalQuestions: state.questions.length,
      correctAnswers: state.score ~/ 100, // Simplistic mapping for now
      wrongAnswers: state.questions.length - (state.score ~/ 100),
      totalDuration: DateTime.now().difference(state.startTime!),
      accuracy: (state.score / (state.questions.length * 100)) * 100,
      maxStreak: _progression?.state.maxStreak ?? state.streak,
      answers: state.answerHistory,
      timestamp: DateTime.now(),
    );

    analytics?.trackEvent('Session Ended', {
      'status': finalLifecycle.name,
      'score': result.finalScore,
    });

    if (finalLifecycle == GameLifecycle.completed || finalLifecycle == GameLifecycle.failed) {
      _repository?.recordGameResult(result);
      _repository?.clearActiveSession();
    }
  }
}

/// Abstract interface for tracking gameplay events.
abstract class AnalyticsHook {
  void trackEvent(String name, Map<String, dynamic> properties);
}

/// Provider for a specific game configuration.
final gameEngineProvider =
    StateNotifierProvider.autoDispose.family<GameEngine, GameState, GameConfiguration>((
      ref,
      config,
    ) {
      final processor = ref.watch(answerProcessorProvider);
      final timer = ref.watch(timerEngineProvider.notifier);
      final progression = ref.watch(progressionProvider.notifier);
      final integrity = ref.watch(integrityProvider.notifier);
      final repository = ref.watch(gameplayRepositoryProvider);

      final engine = GameEngine(
        config: config,
        analytics: null,
        answerProcessor: processor,
        timerEngine: timer,
        progression: progression,
        integrity: integrity,
        repository: repository,
        ref: ref,
      );

      final lifelines = ref.watch(
        lifelineControllerProvider(engine.debugState.sessionId).notifier,
      );
      engine.setLifelineController(lifelines);

      return engine;
    });
