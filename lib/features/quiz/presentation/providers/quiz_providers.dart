import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../domain/usecases/load_questions_use_case.dart';
import '../../domain/usecases/create_quiz_session_use_case.dart';
import '../../domain/usecases/submit_answer_use_case.dart';
import '../../domain/usecases/finish_quiz_use_case.dart';
import '../../domain/usecases/calculate_score_use_case.dart';
import '../../domain/usecases/restore_session_use_case.dart';
import '../../domain/usecases/save_progress_use_case.dart';
import '../../domain/usecases/validate_answer_use_case.dart';
import '../controllers/quiz_controller.dart';
import '../states/quiz_state.dart';

// --- Repository Contract ---
// Implementation will be provided via overrides or a specific implementation provider
final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  throw UnimplementedError('QuizRepository must be implemented');
});

// --- Use Cases ---
final loadQuestionsUseCaseProvider = Provider((ref) {
  return LoadQuestionsUseCase(ref.watch(quizRepositoryProvider));
});

final createQuizSessionUseCaseProvider = Provider((ref) {
  return CreateQuizSessionUseCase(ref.watch(quizRepositoryProvider));
});

final submitAnswerUseCaseProvider = Provider((ref) {
  return SubmitAnswerUseCase(ref.watch(quizRepositoryProvider));
});

final finishQuizUseCaseProvider = Provider((ref) {
  return FinishQuizUseCase(ref.watch(quizRepositoryProvider));
});

final calculateScoreUseCaseProvider = Provider((ref) {
  return CalculateScoreUseCase(ref.watch(quizRepositoryProvider));
});

final restoreSessionUseCaseProvider = Provider((ref) {
  return RestoreSessionUseCase(ref.watch(quizRepositoryProvider));
});

final saveProgressUseCaseProvider = Provider((ref) {
  return SaveProgressUseCase(ref.watch(quizRepositoryProvider));
});

final validateAnswerUseCaseProvider = Provider((ref) {
  return ValidateAnswerUseCase(ref.watch(quizRepositoryProvider));
});

// --- Controller ---
final quizControllerProvider = NotifierProvider<QuizController, QuizState>(
  QuizController.new,
);

// --- Selectors ---
final quizSessionProvider = Provider((ref) {
  return ref.watch(quizControllerProvider.select((s) => s.session));
});

final currentQuestionProvider = Provider((ref) {
  return ref.watch(quizControllerProvider.select((s) => s.currentQuestion));
});

final quizTimerProvider = Provider((ref) {
  return ref.watch(quizControllerProvider.select((s) => s.timer));
});

final quizPowerUpsProvider = Provider((ref) {
  return ref.watch(quizControllerProvider.select((s) => s.powerUps));
});
