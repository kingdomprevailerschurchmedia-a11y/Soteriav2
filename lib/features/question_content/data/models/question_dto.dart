import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_dto.freezed.dart';
part 'question_dto.g.dart';

@freezed
abstract class QuestionDto with _$QuestionDto {
  const factory QuestionDto({
    required String id,
    required String text,
    String? explanation,
    required String difficulty,
    required String categoryId,
    String? subcategoryId,
    String? topicId,
    required String type,
    required List<AnswerDto> options,
    required List<String> correctOptionIds,
    @Default([]) List<String> tags,
    @Default('en') String language,
    @Default(30) int estimatedTimeSeconds,
    @Default(10) int xpValue,
    @Default(5) int coinValue,
    @Default('draft') String status,
    @Default('1.0.0') String version,
    required String createdAt,
    required String updatedAt,
    String? author,
    required String source,
    @Default(1) int schemaVersion,
    String? contentHash,
    @Default({}) Map<String, dynamic> metadata,
  }) = _QuestionDto;

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);
}

@freezed
abstract class AnswerDto with _$AnswerDto {
  const factory AnswerDto({
    required String id,
    required String text,
    String? mediaUrl,
    @Default(0) int displayOrder,
  }) = _AnswerDto;

  factory AnswerDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerDtoFromJson(json);
}
