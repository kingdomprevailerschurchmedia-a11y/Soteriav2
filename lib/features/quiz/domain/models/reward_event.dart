import 'package:freezed_annotation/freezed_annotation.dart';
import 'score_result.dart';

part 'reward_event.freezed.dart';

@freezed
abstract class RewardEvent with _$RewardEvent {
  const factory RewardEvent.questionCorrect({
    required String questionId,
    required ScoreResult result,
    required int newStreak,
  }) = QuestionCorrectEvent;

  const factory RewardEvent.questionIncorrect({
    required String questionId,
    required int streakResetTo,
  }) = QuestionIncorrectEvent;

  const factory RewardEvent.questionTimedOut({
    required String questionId,
    required int streakResetTo,
  }) = QuestionTimedOutEvent;

  const factory RewardEvent.quizCompleted({
    required int finalScore,
    required int totalXp,
    required int perfectStreak,
    required double accuracy,
  }) = QuizCompletedEvent;
}
