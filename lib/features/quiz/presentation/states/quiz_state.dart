import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/question.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/models/timer_state.dart';
import '../../domain/models/power_up_state.dart';
import '../../domain/models/player_answer.dart';
import '../../domain/models/score_result.dart';
import '../../domain/models/reward_event.dart';

part 'quiz_state.freezed.dart';

@freezed
abstract class QuizState with _$QuizState {
  const factory QuizState({
    @Default(QuizStatus.idle) QuizStatus status,
    Question? currentQuestion,
    @Default(0) int currentIndex,
    @Default([]) List<Question> questions,
    QuizSession? session,
    QuizResult? result,
    @Default(0) int score,
    @Default(0) int streak,
    @Default(0) int bestStreak,
    @Default(0) int xp,
    ScoreResult? lastScoreResult,
    @Default([]) List<RewardEvent> rewardEvents,
    @Default([]) List<PlayerAnswer> answeredQuestions,
    TimerState? timer,
    @Default([]) List<PowerUpState> powerUps,
    @Default({}) Set<String> hiddenOptionIds,
    @Default({}) Map<String, double> audienceDistribution,
    TimerState? powerUpTimer,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isOffline,
    String? selectedOptionId,
    @Default(false) bool isAnswerLocked,
    DateTime? questionStartTime,
  }) = _QuizState;
}
