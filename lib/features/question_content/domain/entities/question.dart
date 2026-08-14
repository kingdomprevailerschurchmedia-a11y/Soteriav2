import 'package:freezed_annotation/freezed_annotation.dart';
import 'difficulty.dart';

part 'question.freezed.dart';
part 'question.g.dart';

/// Represents the different types of questions supported by Soteria.
enum QuestionType {
  multipleChoice,
  trueFalse,
  multipleSelect,
  image,
  audio,
  video,
  fillInBlank,
  ordering,
  matching,
}

/// Represents the lifecycle status of a question in the content bank.
enum QuestionStatus {
  draft,
  review,
  approved,
  published,
  archived,
  rejected,
}

@freezed
abstract class Question with _$Question {
  const factory Question({
    required String id,
    required String text,
    String? explanation,
    required Difficulty difficulty,
    required String categoryId,
    String? subcategoryId,
    String? topicId,
    required QuestionType type,
    required List<Answer> options,
    /// Authoritative correct answer IDs. 
    /// CRITICAL: This must be stripped in client-facing competitive payloads.
    required List<String> correctOptionIds,
    @Default([]) List<String> tags,
    @Default('en') String language,
    @Default(Duration(seconds: 30)) Duration estimatedTime,
    @Default(10) int xpValue,
    @Default(5) int coinValue,
    @Default(QuestionStatus.draft) QuestionStatus status,
    @Default('1.0.0') String version,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? author,
    required String source,
    @Default(1) int schemaVersion,
    String? contentHash,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  const Question._();

  bool isAnswerCorrect(String answerId) => correctOptionIds.contains(answerId);

  bool areAnswersCorrect(List<String> answerIds) {
    if (answerIds.length != correctOptionIds.length) return false;
    return answerIds.every((id) => correctOptionIds.contains(id));
  }
}

@freezed
abstract class Answer with _$Answer {
  const factory Answer({
    required String id,
    required String text,
    String? mediaUrl,
    @Default(0) int displayOrder,
  }) = _Answer;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
}
