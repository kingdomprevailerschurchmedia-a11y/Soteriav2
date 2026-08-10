import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';
import 'player_answer.dart';
import 'power_up_state.dart';
import 'timer_state.dart';

part 'quiz_session.freezed.dart';
part 'quiz_session.g.dart';

@freezed
abstract class QuizSession with _$QuizSession {
  const factory QuizSession({
    required String sessionId,
    required String playerId,
    required GameMode gameMode,
    required String category,
    required Difficulty difficulty,
    required DateTime startedTime,
    DateTime? endedTime,
    DateTime? lastUpdatedTime,
    @Default(0) int currentQuestionIndex,
    String? currentQuestionId,
    @Default([]) List<String> questionIds,
    @Default([]) List<PlayerAnswer> answeredQuestions,
    @Default(0) int remainingQuestions,
    @Default(0) int currentScore,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
    @Default(0.0) double accuracy,
    @Default(0) int xpEarned,
    @Default(0) int coinsEarned,
    @Default(QuizStatus.idle) QuizStatus completionStatus,
    @Default(SessionStatus.created) SessionStatus sessionStatus,
    @Default([]) List<PowerUpState> powerUps,
    TimerState? timerState,
    DateTime? questionStartTime,
    @Default(1) int version,
  }) = _QuizSession;

  factory QuizSession.fromJson(Map<String, dynamic> json) =>
      _$QuizSessionFromJson(json);
}
