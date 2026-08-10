import 'package:flutter_riverpod/flutter_riverpod.dart';
export '../../data/repository/quiz_repository_provider.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../domain/usecases/load_questions_use_case.dart';
import '../../domain/usecases/create_quiz_session_use_case.dart';
import '../../domain/usecases/submit_answer_use_case.dart';
import '../../domain/usecases/finish_quiz_use_case.dart';
import '../../domain/usecases/calculate_score_use_case.dart';
import '../../domain/usecases/restore_session_use_case.dart';
import '../../domain/usecases/save_progress_use_case.dart';
import '../../domain/usecases/validate_answer_use_case.dart';
import '../../domain/usecases/load_active_session_use_case.dart';
import '../../domain/usecases/delete_session_use_case.dart';
import '../../domain/repositories/quiz_session_repository.dart';
import '../controllers/quiz_controller.dart';
import '../states/quiz_state.dart';
import '../../data/repository/quiz_repository_provider.dart';
import '../../data/repository/quiz_session_repository_impl.dart';

import '../../domain/usecases/history/get_quiz_history_use_case.dart';
import '../../domain/usecases/history/get_performance_summary_use_case.dart';
import '../../domain/usecases/history/get_category_performance_use_case.dart';
import '../../domain/usecases/history/get_difficulty_performance_use_case.dart';
import '../../domain/usecases/history/get_trend_analysis_use_case.dart';

// --- Repository Contract ---
final quizSessionRepositoryProvider = Provider<QuizSessionRepository>((ref) {
  return QuizSessionRepositoryImpl(ref.watch(quizLocalDataSourceProvider));
});

// History Repository already defined in quiz_repository_provider.dart
// But we can re-export or alias it here if needed for consistency

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

final loadActiveSessionUseCaseProvider = Provider((ref) {
  return LoadActiveSessionUseCase(ref.watch(quizSessionRepositoryProvider));
});

final deleteSessionUseCaseProvider = Provider((ref) {
  return DeleteSessionUseCase(ref.watch(quizSessionRepositoryProvider));
});

// --- History Use Cases ---
final getQuizHistoryUseCaseProvider = Provider((ref) {
  return GetQuizHistoryUseCase(ref.watch(quizHistoryRepositoryProvider));
});

final getPerformanceSummaryUseCaseProvider = Provider((ref) {
  return GetPerformanceSummaryUseCase(ref.watch(quizHistoryRepositoryProvider));
});

final getCategoryPerformanceUseCaseProvider = Provider((ref) {
  return GetCategoryPerformanceUseCase(ref.watch(quizHistoryRepositoryProvider));
});

final getDifficultyPerformanceUseCaseProvider = Provider((ref) {
  return GetDifficultyPerformanceUseCase(ref.watch(quizHistoryRepositoryProvider));
});

final getTrendAnalysisUseCaseProvider = Provider((ref) {
  return GetTrendAnalysisUseCase(ref.watch(quizHistoryRepositoryProvider));
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
