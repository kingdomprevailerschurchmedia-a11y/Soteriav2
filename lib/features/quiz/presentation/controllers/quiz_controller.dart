import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/player_answer.dart';
import '../../domain/models/quiz_session.dart';
import '../states/quiz_state.dart';
import '../providers/quiz_providers.dart';

class QuizController extends Notifier<QuizState> {
  @override
  QuizState build() {
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
      );
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

  Future<void> submitAnswer(PlayerAnswer answer) async {
    if (state.session == null) return;

    try {
      final submittedAnswer = await ref
          .read(submitAnswerUseCaseProvider)
          .execute(sessionId: state.session!.sessionId, answer: answer);

      final updatedAnswers = [
        ...state.session!.answeredQuestions,
        submittedAnswer,
      ];
      final isCorrect = submittedAnswer.isCorrect;
      final newStreak = isCorrect ? state.streak + 1 : 0;
      final newScore = isCorrect ? state.score + 100 : state.score;

      final updatedSession = state.session!.copyWith(
        answeredQuestions: updatedAnswers,
        currentStreak: newStreak,
        currentScore: newScore,
        currentQuestionIndex: state.currentIndex,
      );

      state = state.copyWith(
        streak: newStreak,
        score: newScore,
        session: updatedSession,
      );

      await ref.read(saveProgressUseCaseProvider).execute(updatedSession);

      _nextQuestion();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void skipQuestion() {
    if (state.session == null) return;

    final skipAnswer = PlayerAnswer(
      questionId: state.currentQuestion?.id ?? '',
      selectedOptionIds: [],
      isCorrect: false,
      responseTime: Duration.zero,
      timestamp: DateTime.now(),
      isSkipped: true,
    );

    submitAnswer(skipAnswer);
  }

  void _nextQuestion() {
    final nextIndex = state.currentIndex + 1;
    if (nextIndex < state.questions.length) {
      state = state.copyWith(
        currentIndex: nextIndex,
        currentQuestion: state.questions[nextIndex],
      );
    } else {
      finishQuiz();
    }
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
