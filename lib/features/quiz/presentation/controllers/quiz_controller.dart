import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/clock_provider.dart';
import '../../domain/services/timer_engine.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/player_answer.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/timer_state.dart';
import '../../domain/models/scoring_configuration.dart';
import '../../domain/models/reward_event.dart';
import '../../domain/models/power_up_state.dart';
import '../../domain/models/power_up_usage.dart';
import '../../domain/models/power_up_configuration.dart';
import '../../domain/models/answer_option.dart';
import '../../domain/services/quiz_scoring_engine.dart';
import '../states/quiz_state.dart';
import '../providers/quiz_providers.dart';

import '../../domain/models/question_result.dart';
import '../../domain/models/quiz_result.dart';

class QuizController extends Notifier<QuizState> {
  Timer? _ticker;
  static const _kTickDuration = Duration(milliseconds: 100);

  final _scoringEngine = QuizScoringEngine(
    config: ScoringConfiguration.standard(),
  );

  @override
  QuizState build() {
    ref.onDispose(() => _ticker?.cancel());
    return const QuizState();
  }

  Future<void> startQuiz({
    required String playerId,
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final session = await ref.read(createQuizSessionUseCaseProvider).execute(
        playerId: playerId,
        mode: mode,
        category: category,
        difficulty: difficulty,
      );

      final questions = await ref.read(loadQuestionsUseCaseProvider).execute(
        mode: mode,
        category: category,
        difficulty: difficulty,
      );

      final updatedSession = session.copyWith(
        questionIds: questions.map((q) => q.id).toList(),
        currentQuestionId: questions.isNotEmpty ? questions.first.id : null,
        sessionStatus: SessionStatus.active,
        lastUpdatedTime: DateTime.now(),
      );

      state = state.copyWith(
        isLoading: false,
        status: QuizStatus.active,
        session: updatedSession,
        powerUps: updatedSession.powerUps,
        questions: questions,
        currentQuestion: questions.isNotEmpty ? questions.first : null,
        currentIndex: 0,
        questionStartTime: DateTime.now(),
      );

      await _persistSession();

      if (state.currentQuestion != null) {
        _startTimer(Duration(seconds: state.currentQuestion!.estimatedTime));
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> restoreQuiz(String sessionId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final session =
          await ref.read(restoreSessionUseCaseProvider).execute(sessionId);
      if (session != null) {
        // Re-load questions based on questionIds in session
        // In a real scenario, QuestionRepository should support loading by IDs
        // For now, we'll re-load based on criteria and then filter/align
        final questions = await ref.read(loadQuestionsUseCaseProvider).execute(
          mode: session.gameMode,
          category: session.category,
          difficulty: session.difficulty,
        );

        final currentQuestion = questions.firstWhere(
          (q) => q.id == session.currentQuestionId,
          orElse: () => questions[session.currentQuestionIndex],
        );

        state = state.copyWith(
          isLoading: false,
          status: session.completionStatus == QuizStatus.completed
              ? QuizStatus.completed
              : QuizStatus.active,
          session: session,
          powerUps: session.powerUps,
          questions: questions,
          currentQuestion: currentQuestion,
          score: session.currentScore,
          streak: session.currentStreak,
          bestStreak: session.bestStreak,
          xp: session.xpEarned,
          currentIndex: session.currentQuestionIndex,
          answeredQuestions: session.answeredQuestions,
        );

        if (state.status == QuizStatus.active) {
          _recoverTimer(session);
        }
      } else {
        state = state.copyWith(isLoading: false, error: 'Session not found');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void _recoverTimer(QuizSession session) {
    if (session.timerState == null || session.questionStartTime == null) {
      _startTimer(
        Duration(
          seconds: state.currentQuestion?.estimatedTime ?? 30,
        ),
      );
      return;
    }

    final now = DateTime.now();
    final elapsedSinceStart = now.difference(session.questionStartTime!);
    final totalDuration = session.timerState!.totalDuration;
    final remaining = totalDuration - elapsedSinceStart;

    if (remaining <= Duration.zero) {
      // Timer expired while app was closed
      state = state.copyWith(
        timer: session.timerState!.copyWith(
          remainingTime: Duration.zero,
          progress: 0,
          hasExpired: true,
          isRunning: false,
        ),
      );
      _handleTimeout();
    } else {
      final deadline = now.add(remaining);
      state = state.copyWith(
        timer: session.timerState!.copyWith(
          remainingTime: remaining,
          deadline: deadline,
          isRunning: true,
        ),
      );
      _ticker = Timer.periodic(_kTickDuration, (_) => _onTick());
    }
  }

  Future<void> _persistSession() async {
    if (state.session == null) return;

    final updatedSession = state.session!.copyWith(
      currentQuestionIndex: state.currentIndex,
      currentQuestionId: state.currentQuestion?.id,
      currentScore: state.score,
      currentStreak: state.streak,
      bestStreak: state.bestStreak,
      xpEarned: state.xp,
      powerUps: state.powerUps,
      answeredQuestions: state.answeredQuestions,
      timerState: state.timer,
      questionStartTime: state.questionStartTime,
      lastUpdatedTime: DateTime.now(),
    );

    await ref.read(quizSessionRepositoryProvider).saveSession(updatedSession);
    state = state.copyWith(session: updatedSession);
  }

  Future<void> selectAnswer(String optionId) async {
    // 1. Protection & State Guard
    if (state.isAnswerLocked || state.status != QuizStatus.active) return;
    if (state.currentQuestion == null) return;

    // 2. Lock UI immediately
    _stopTimer();
    state = state.copyWith(selectedOptionId: optionId, isAnswerLocked: true);

    final startTime = state.questionStartTime ?? DateTime.now();
    final responseTime = DateTime.now().difference(startTime);

    try {
      // 3. Validation (Local for immediate feedback, prepared for server)
      final isCorrect = state.currentQuestion!.correctOptionIds.contains(
        optionId,
      );

      // 4. Record Answer
      final answer = PlayerAnswer(
        questionId: state.currentQuestion!.id,
        selectedOptionIds: [optionId],
        isCorrect: isCorrect,
        responseTime: responseTime,
        timestamp: DateTime.now(),
      );

      // 5. Submit to Repository
      if (state.session != null) {
        await ref
            .read(submitAnswerUseCaseProvider)
            .execute(sessionId: state.session!.sessionId, answer: answer);

        _applyRewards(answer);
        await _persistSession();
      }

      // 6. Delay for visual feedback (Premium feel)
      await Future.delayed(const Duration(milliseconds: 1500));

      // 7. Proceed
      _nextQuestion();
    } catch (e) {
      // Handle submission error (Recoverable)
      state = state.copyWith(
        isAnswerLocked: false,
        selectedOptionId: null,
        error: 'Unable to submit answer. Please try again.',
      );
    }
  }

  void skipQuestion() {
    if (state.isAnswerLocked) return;

    final skipAnswer = PlayerAnswer(
      questionId: state.currentQuestion?.id ?? '',
      selectedOptionIds: [],
      isCorrect: false,
      responseTime: Duration.zero,
      timestamp: DateTime.now(),
      isSkipped: true,
    );

    _submitInternal(skipAnswer);
  }

  Future<void> _submitInternal(PlayerAnswer answer) async {
    if (state.session == null) return;
    try {
      await ref
          .read(submitAnswerUseCaseProvider)
          .execute(sessionId: state.session!.sessionId, answer: answer);
      _applyRewards(answer);
      _nextQuestion();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void _applyRewards(PlayerAnswer answer) {
    if (state.currentQuestion == null) return;

    final result = _scoringEngine.calculate(
      state.currentQuestion!,
      answer,
      state.streak,
    );

    final newStreak = _scoringEngine.calculateNewStreak(state.streak, answer);
    final newBestStreak = newStreak > state.bestStreak
        ? newStreak
        : state.bestStreak;

    RewardEvent? event;
    if (answer.isCorrect) {
      event = RewardEvent.questionCorrect(
        questionId: state.currentQuestion!.id,
        result: result,
        newStreak: newStreak,
      );
    } else if (answer.isTimedOut) {
      event = RewardEvent.questionTimedOut(
        questionId: state.currentQuestion!.id,
        streakResetTo: 0,
      );
    } else if (answer.isSkipped) {
      // Skips don't have a specific event yet in my model, but could reset streak
    } else {
      event = RewardEvent.questionIncorrect(
        questionId: state.currentQuestion!.id,
        streakResetTo: 0,
      );
    }

    state = state.copyWith(
      score: state.score + result.totalScore,
      xp: state.xp + result.xpEarned,
      streak: newStreak,
      bestStreak: newBestStreak,
      lastScoreResult: result,
      rewardEvents: event != null
          ? [...state.rewardEvents, event]
          : state.rewardEvents,
      answeredQuestions: [...state.answeredQuestions, answer],
    );
    _persistSession();
  }

  void _nextQuestion() {
    final nextIndex = state.currentIndex + 1;
    if (nextIndex < state.questions.length) {
      final nextQuestion = state.questions[nextIndex];
      state = state.copyWith(
        currentIndex: nextIndex,
        currentQuestion: nextQuestion,
        selectedOptionId: null,
        isAnswerLocked: false,
        questionStartTime: DateTime.now(),
        hiddenOptionIds: {},
        audienceDistribution: {},
        powerUpTimer: null,
      );
      _persistSession();
      _startTimer(Duration(seconds: nextQuestion.estimatedTime));
    } else {
      finishQuiz();
    }
  }

  void _startTimer(Duration duration) {
    _ticker?.cancel();
    final clock = ref.read(clockProvider);
    final deadline = clock.now().add(duration);

    state = state.copyWith(
      timer: TimerState(
        totalDuration: duration,
        remainingTime: duration,
        deadline: deadline,
        status: TimerStatus.running,
        isRunning: true,
      ),
    );

    _ticker = Timer.periodic(_kTickDuration, (_) => _onTick());
  }

  void _stopTimer() {
    _ticker?.cancel();
    state = state.copyWith(
      timer: state.timer?.copyWith(isRunning: false, status: TimerStatus.idle),
    );
  }

  void _onTick() {
    final clock = ref.read(clockProvider);
    final engine = TimerEngine(clock: clock);

    // 1. Tick power-up timer if active (e.g. Pause Timer)
    if (state.powerUpTimer != null && state.powerUpTimer!.isRunning) {
      final updatedPowerUpTimer = engine.tick(state.powerUpTimer!);
      state = state.copyWith(powerUpTimer: updatedPowerUpTimer);

      if (updatedPowerUpTimer.hasExpired) {
        // Resume main timer
        if (state.timer != null) {
          final resumedTimer = engine.resume(
            state.timer!,
            updatedPowerUpTimer.totalDuration,
          );
          state = state.copyWith(timer: resumedTimer, powerUpTimer: null);
        } else {
          state = state.copyWith(powerUpTimer: null);
        }
      }
      return; // While power-up timer is running, main timer is paused
    }

    // 2. Tick main timer
    final timer = state.timer;
    if (timer == null || !timer.isRunning || timer.deadline == null) return;

    final updatedTimer = engine.tick(timer);
    state = state.copyWith(timer: updatedTimer);

    if (updatedTimer.hasExpired) {
      _ticker?.cancel();
      _handleTimeout();
    }
  }

  Future<void> _handleTimeout() async {
    // Atomic check: If answer already locked, timer expiration arrived late
    if (state.isAnswerLocked) return;

    state = state.copyWith(isAnswerLocked: true);

    final timeoutAnswer = PlayerAnswer(
      questionId: state.currentQuestion?.id ?? '',
      selectedOptionIds: [],
      isCorrect: false,
      responseTime: state.timer?.totalDuration ?? Duration.zero,
      timestamp: DateTime.now(),
      isTimedOut: true, // Assuming PlayerAnswer model will be updated for this
    );

    if (state.session != null) {
      await ref
          .read(submitAnswerUseCaseProvider)
          .execute(sessionId: state.session!.sessionId, answer: timeoutAnswer);
      _applyRewards(timeoutAnswer);
      await _persistSession();
    }

    await Future.delayed(const Duration(milliseconds: 1500));
    _nextQuestion();
  }

  Future<void> finishQuiz() async {
    if (state.session == null || state.status == QuizStatus.completed) return;

    state = state.copyWith(isLoading: true);

    try {
      final quizResult = await finalizeQuiz();

      state = state.copyWith(
        isLoading: false,
        status: QuizStatus.completed,
        result: quizResult,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<QuizResult> finalizeQuiz() async {
    final session = state.session;
    if (session == null) throw Exception('No active session to finalize');

    // Idempotency: Return existing result if already finalized
    if (state.result != null && state.result!.sessionId == session.sessionId) {
      return state.result!;
    }

    final answers = state.answeredQuestions;
    final totalQuestions = state.questions.length;

    int correct = 0;
    int incorrect = 0;
    int skipped = 0;
    int timedOut = 0;
    List<Duration> responseTimes = [];

    final List<QuestionResult> questionResults = [];

    for (int i = 0; i < totalQuestions; i++) {
      final question = state.questions[i];
      final answer = answers.firstWhere(
        (a) => a.questionId == question.id,
        orElse: () => PlayerAnswer(
          questionId: question.id,
          selectedOptionIds: [],
          isCorrect: false,
          responseTime: Duration.zero,
          timestamp: DateTime.now(),
          isSkipped: true, // Default to skipped if no answer found
        ),
      );

      QuestionOutcome outcome;
      if (answer.isCorrect) {
        correct++;
        outcome = QuestionOutcome.correct;
      } else if (answer.isTimedOut) {
        timedOut++;
        outcome = QuestionOutcome.timedOut;
      } else if (answer.isSkipped || answer.selectedOptionIds.isEmpty) {
        skipped++;
        outcome = QuestionOutcome.skipped;
      } else {
        incorrect++;
        outcome = QuestionOutcome.incorrect;
      }

      if (!answer.isSkipped && !answer.isTimedOut) {
        responseTimes.add(answer.responseTime);
      }

      final selectedOption = answer.selectedOptionIds.isNotEmpty
          ? question.options.firstWhere(
              (o) => o.id == answer.selectedOptionIds.first,
              orElse: () => const AnswerOption(id: '', text: 'N/A'),
            )
          : null;

      final correctOption = question.options.firstWhere(
        (o) => question.correctOptionIds.contains(o.id),
        orElse: () => question.options.first,
      );

      questionResults.add(QuestionResult(
        questionId: question.id,
        questionNumber: i + 1,
        questionText: question.text,
        outcome: outcome,
        selectedOptionId: selectedOption?.id,
        selectedOptionText: selectedOption?.text,
        correctOptionIds: question.correctOptionIds,
        correctOptionText: correctOption.text,
        responseTime: answer.responseTime,
        scoreEarned: answer.isCorrect ? 100 : 0, // Simplified for now
        difficulty: question.difficulty,
        explanation: question.explanation,
      ));
    }

    final accuracy = totalQuestions > 0 ? correct / totalQuestions : 0.0;
    final avgResponseTime = responseTimes.isNotEmpty
        ? Duration(
            milliseconds: responseTimes
                    .map((d) => d.inMilliseconds)
                    .reduce((a, b) => a + b) ~/
                responseTimes.length,
          )
        : Duration.zero;

    final fastest = responseTimes.isNotEmpty
        ? responseTimes.reduce((a, b) => a < b ? a : b)
        : Duration.zero;

    final slowest = responseTimes.isNotEmpty
        ? responseTimes.reduce((a, b) => a > b ? a : b)
        : Duration.zero;

    final quizResult = QuizResult(
      sessionId: session.sessionId,
      playerId: session.playerId,
      gameMode: session.gameMode,
      category: session.category,
      difficulty: session.difficulty,
      totalQuestions: totalQuestions,
      answeredQuestions: answers.length,
      correctAnswers: correct,
      wrongAnswers: incorrect,
      skipped: skipped,
      timedOut: timedOut,
      accuracy: accuracy,
      finalScore: state.score,
      xpEarned: state.xp,
      coinsEarned: 0,
      longestStreak: state.bestStreak,
      finalStreak: state.streak,
      averageResponseTime: avgResponseTime,
      fastestResponseTime: fastest,
      slowestResponseTime: slowest,
      questionResults: questionResults,
      powerUpsUsed: session.powerUps
          .where((p) => p.status == PowerUpStatus.used)
          .map((p) => p.type)
          .toList(),
      completedAt: DateTime.now(),
      completionTime: DateTime.now().difference(session.startedTime),
      performanceRating: _generatePerformanceRating(accuracy),
    );

    // Persist result
    final updatedSession = session.copyWith(
      sessionStatus: SessionStatus.completed,
      completionStatus: QuizStatus.completed,
      lastUpdatedTime: DateTime.now(),
    );
    await ref.read(quizSessionRepositoryProvider).saveSession(updatedSession);
    
    // Save the QuizResult to history repository
    await ref.read(quizHistoryRepositoryProvider).addResult(quizResult);
    
    return quizResult;
  }

  String _generatePerformanceRating(double accuracy) {
    if (accuracy >= 0.95) return 'Exceptional';
    if (accuracy >= 0.85) return 'Excellent';
    if (accuracy >= 0.70) return 'Strong';
    if (accuracy >= 0.50) return 'Good';
    return 'Keep Practicing';
  }

  Future<void> activatePowerUp(PowerUpType type) async {
    // 1. Verify quiz is active
    if (state.status != QuizStatus.active || state.currentQuestion == null) {
      return;
    }

    // 2. Find power-up
    final powerUps = state.powerUps.isNotEmpty
        ? state.powerUps
        : (state.session?.powerUps ?? []);
    final powerUpIndex = powerUps.indexWhere((p) => p.type == type);
    if (powerUpIndex == -1) return;

    final powerUp = powerUps[powerUpIndex];

    // 3. Verify availability & lock
    if (powerUp.status != PowerUpStatus.available ||
        powerUp.remainingUses <= 0) {
      return;
    }

    // Prevent double activation or conflicting activations
    if (powerUps.any((p) => p.status == PowerUpStatus.activating)) return;

    // Set to activating
    final updatedPowerUps = List<PowerUpState>.from(powerUps);
    updatedPowerUps[powerUpIndex] = powerUp.copyWith(
      status: PowerUpStatus.activating,
    );
    state = state.copyWith(powerUps: updatedPowerUps);

    try {
      // 4. Apply effect
      Map<String, dynamic> result = {};
      switch (type) {
        case PowerUpType.fiftyFifty:
          result = await _applyFiftyFifty();
          break;
        case PowerUpType.pauseTimer:
          result = await _applyPauseTimer();
          break;
        case PowerUpType.askAudience:
          result = await _applyAskAudience();
          break;
        default:
          throw UnimplementedError('Power-up $type not implemented');
      }

      // 5. Mark used & record usage
      final finalPowerUps = List<PowerUpState>.from(state.powerUps);
      final usage = PowerUpUsage(
        usageId: 'usage_${DateTime.now().millisecondsSinceEpoch}',
        type: type,
        sessionId: state.session?.sessionId ?? '',
        roundIndex: state.currentIndex,
        questionId: state.currentQuestion?.id ?? '',
        activatedAt: DateTime.now(),
        result: result,
      );

      finalPowerUps[powerUpIndex] = powerUp.copyWith(
        status: PowerUpStatus.used,
        remainingUses: powerUp.remainingUses - 1,
        usageHistory: [...powerUp.usageHistory, usage],
      );

      state = state.copyWith(powerUps: finalPowerUps);

      // Persist session
      await _persistSession();
    } catch (e) {
      // Revert to available on failure
      final errorPowerUps = List<PowerUpState>.from(state.powerUps);
      errorPowerUps[powerUpIndex] = powerUp.copyWith(
        status: PowerUpStatus.available,
      );
      state = state.copyWith(powerUps: errorPowerUps, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> _applyFiftyFifty() async {
    final question = state.currentQuestion;
    if (question == null) return {};

    final options = question.options;
    final correctIds = question.correctOptionIds;

    final incorrectOptions = options
        .where((o) => !correctIds.contains(o.id))
        .toList();

    if (incorrectOptions.length < 2) {
      // For 2-option questions, we can only remove 1 if we want to keep 1 correct and 1 incorrect.
      // But requirement says "exactly two".
      // If we only have 1 incorrect, we can't remove 2.
      // I'll remove as many as possible up to 2, keeping at least 1 incorrect.
      if (incorrectOptions.isEmpty) return {};
      final toRemove = {incorrectOptions.first.id};
      state = state.copyWith(hiddenOptionIds: toRemove);
      return {'hiddenOptionIds': toRemove.toList()};
    }

    // Shuffle and pick 2
    incorrectOptions.shuffle();
    final toRemove = incorrectOptions.take(2).map((o) => o.id).toSet();

    state = state.copyWith(hiddenOptionIds: toRemove);
    return {'hiddenOptionIds': toRemove.toList()};
  }

  Future<Map<String, dynamic>> _applyPauseTimer() async {
    if (state.timer == null) return {};

    final clock = ref.read(clockProvider);
    final engine = TimerEngine(clock: clock);

    // Pause main timer
    final pausedTimer = engine.pause(state.timer!);

    // Create power-up timer for the pause duration
    const config = PowerUpConfiguration();
    final pauseDuration = Duration(seconds: config.maxPauseDurationSeconds);
    final powerUpTimer = engine.createTimer(pauseDuration);

    state = state.copyWith(timer: pausedTimer, powerUpTimer: powerUpTimer);

    return {'duration': pauseDuration.inSeconds};
  }

  Future<Map<String, dynamic>> _applyAskAudience() async {
    final question = state.currentQuestion;
    if (question == null) return {};

    final availableOptions = question.options
        .where((o) => !state.hiddenOptionIds.contains(o.id))
        .toList();
    final correctIds = question.correctOptionIds;

    // Generate distribution
    final distribution = _generateAudienceDistribution(
      availableOptions,
      correctIds,
    );

    state = state.copyWith(audienceDistribution: distribution);
    return {'distribution': distribution};
  }

  Map<String, double> _generateAudienceDistribution(
    List<AnswerOption> availableOptions,
    List<String> correctIds,
  ) {
    final Map<String, double> distribution = {};
    if (availableOptions.isEmpty) return distribution;

    final correctOption = availableOptions.firstWhere(
      (o) => correctIds.contains(o.id),
      orElse: () => availableOptions.first,
    );

    // Probability types:
    // 0: Strongly favored (60-80%)
    // 1: Moderately favored (40-60%)
    // 2: Incorrect slightly favored
    // 3: Near tie

    final random = DateTime.now().millisecond % 4;
    double correctWeight;

    switch (random) {
      case 0:
        correctWeight = 0.75;
        break;
      case 1:
        correctWeight = 0.55;
        break;
      case 2:
        correctWeight = 0.35;
        break;
      case 3:
        correctWeight = 0.48;
        break;
      default:
        correctWeight = 0.6;
    }

    double remainingWeight = 1.0 - correctWeight;
    final incorrectOptions = availableOptions
        .where((o) => o.id != correctOption.id)
        .toList();

    distribution[correctOption.id] = correctWeight;

    if (incorrectOptions.isNotEmpty) {
      for (int i = 0; i < incorrectOptions.length; i++) {
        if (i == incorrectOptions.length - 1) {
          distribution[incorrectOptions[i].id] = remainingWeight;
        } else {
          final weight = remainingWeight * 0.5;
          distribution[incorrectOptions[i].id] = weight;
          remainingWeight -= weight;
        }
      }
    }

    // Ensure they sum to 100% exactly (handle precision)
    double sum = distribution.values.fold(0, (a, b) => a + b);
    if (sum != 1.0) {
      final firstKey = distribution.keys.first;
      distribution[firstKey] = distribution[firstKey]! + (1.0 - sum);
    }

    return distribution;
  }

  void resumeQuiz() {
    state = state.copyWith(status: QuizStatus.active);
  }

  void resetQuiz() {
    state = const QuizState();
  }

  void updateScore(int newScore) {
    state = state.copyWith(score: newScore);
  }

  void updateStreak(int newStreak) {
    state = state.copyWith(streak: newStreak);
  }
}
