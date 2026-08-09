import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_answer.freezed.dart';
part 'player_answer.g.dart';

@freezed
abstract class PlayerAnswer with _$PlayerAnswer {
  const factory PlayerAnswer({
    required String questionId,
    required List<String> selectedOptionIds,
    required bool isCorrect,
    required Duration responseTime,
    required DateTime timestamp,
    @Default(false) bool isSkipped,
    @Default(false) bool isTimedOut,
  }) = _PlayerAnswer;

  factory PlayerAnswer.fromJson(Map<String, dynamic> json) =>
      _$PlayerAnswerFromJson(json);
}
