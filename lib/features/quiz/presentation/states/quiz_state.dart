import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/question.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/models/timer_state.dart';
import '../../domain/models/power_up_state.dart';

part 'quiz_state.freezed.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState({
    @Default(QuizStatus.idle) QuizStatus status,
    Question? currentQuestion,
    @Default(0) int currentIndex,
    @Default([]) List<Question> questions,
    QuizSession? session,
    QuizResult? result,
    @Default(0) int score,
    @Default(0) int streak,
    TimerState? timer,
    @Default([]) List<PowerUpState> powerUps,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isOffline,
  }) = _QuizState;
}
