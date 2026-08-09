import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/services/timer_engine.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/player_answer.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/timer_state.dart';
import '../states/quiz_state.dart';
import '../providers/quiz_providers.dart';

class QuizController extends Notifier<QuizState> {
  Timer? _ticker;
  static const _kTickDuration = Duration(milliseconds: 100);

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
      final session = await ref
          .read(createQuizSessionUseCaseProvider)
          .execute(
            playerId: playerId,
            mode: mode,
            category: category,
            difficulty: difficulty,
          );

      final questions = await ref
          .read(loadQuestionsUseCaseProvider)
          .execute(mode: mode, category: category, difficulty: difficulty);

      state = state.copyWith(
        isLoading: false,
        status: QuizStatus.active,
        session: session,
        questions: questions,
        currentQuestion: questions.isNotEmpty ? questions.first : null,
        currentIndex: 0,
        questionStartTime: DateTime.now(),
      );

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
      final session = await ref
          .read(restoreSessionUseCaseProvider)
          .execute(sessionId);
      if (session != null) {
        // In a real scenario, we'd also re-load questions based on session info
        state = state.copyWith(
          isLoading: false,
          status: session.completionStatus == QuizStatus.completed
              ? QuizStatus.completed
              : QuizStatus.active,
          session: session,
          score: session.currentScore,
          streak: session.currentStreak,
          currentIndex: session.currentQuestionIndex,
        );
      } else {
        state = state.copyWith(isLoading: false, error: 'Session not found');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
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

        // Update local session state (Score/Streak logic simplified as per scope)
        final newStreak = isCorrect ? state.streak + 1 : 0;
        final newScore = isCorrect ? state.score + 100 : state.score;

        state = state.copyWith(streak: newStreak, score: newScore);
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
      _nextQuestion();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
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
      );
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
    final timer = state.timer;
    if (timer == null || !timer.isRunning || timer.deadline == null) return;

    final clock = ref.read(clockProvider);
    final engine = TimerEngine(clock: clock);
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
      state = state.copyWith(streak: 0);
    }

    await Future.delayed(const Duration(milliseconds: 1500));
    _nextQuestion();
  }

  Future<void> finishQuiz() async {
    if (state.session == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final result = await ref
          .read(finishQuizUseCaseProvider)
          .execute(state.session!.sessionId);

      state = state.copyWith(
        isLoading: false,
        status: QuizStatus.completed,
        result: result,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void pauseQuiz() {
    state = state.copyWith(status: QuizStatus.paused);
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
