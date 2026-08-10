import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';

part 'question_result.freezed.dart';
part 'question_result.g.dart';

enum QuestionOutcome { correct, incorrect, skipped, timedOut }

@freezed
abstract class QuestionResult with _$QuestionResult {
  const factory QuestionResult({
    required String questionId,
    required int questionNumber,
    required String questionText,
    required QuestionOutcome outcome,
    String? selectedOptionId,
    String? selectedOptionText,
    required List<String> correctOptionIds,
    required String correctOptionText,
    required Duration responseTime,
    required int scoreEarned,
    Difficulty? difficulty,
    String? explanation,
  }) = _QuestionResult;

  factory QuestionResult.fromJson(Map<String, dynamic> json) =>
      _$QuestionResultFromJson(json);
}
