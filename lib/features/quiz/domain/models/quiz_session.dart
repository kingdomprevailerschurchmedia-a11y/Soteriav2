import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';
import 'player_answer.dart';

part 'quiz_session.freezed.dart';
part 'quiz_session.g.dart';

@freezed
class QuizSession with _$QuizSession {
  const factory QuizSession({
    required String sessionId,
    required String playerId,
    required GameMode gameMode,
    required String category,
    required Difficulty difficulty,
    required DateTime startedTime,
    DateTime? endedTime,
    @Default(0) int currentQuestionIndex,
    @Default([]) List<PlayerAnswer> answeredQuestions,
    @Default(0) int remainingQuestions,
    @Default(0) int currentScore,
    @Default(0) int currentStreak,
    @Default(0) int xpEarned,
    @Default(0) int coinsEarned,
    @Default(QuizStatus.idle) QuizStatus completionStatus,
  }) = _QuizSession;

  factory QuizSession.fromJson(Map<String, dynamic> json) =>
      _$QuizSessionFromJson(json);
}
