import 'package:freezed_annotation/freezed_annotation.dart';
import 'answer_option.dart';
import 'quiz_enums.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required QuestionType type,
    required String category,
    required Difficulty difficulty,
    required String text,
    String? imageUrl,
    String? audioUrl,
    String? videoUrl,
    String? explanation,
    required List<AnswerOption> options,
    required List<String> correctOptionIds,
    @Default([]) List<String> tags,
    @Default(30) int estimatedTime,
    @Default(10) int xpValue,
    @Default(5) int coinValue,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default('active') String status,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
