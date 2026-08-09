import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_dto.freezed.dart';
part 'question_dto.g.dart';

@freezed
abstract class QuestionDto with _$QuestionDto {
  const factory QuestionDto({
    required String id,
    required String type,
    required String category,
    required String difficulty,
    required String text,
    String? imageUrl,
    String? audioUrl,
    String? videoUrl,
    String? explanation,
    required List<Map<String, dynamic>> options,
    required List<String> correctOptionIds,
    @Default([]) List<String> tags,
    required int estimatedTime,
    required int xpValue,
    required int coinValue,
    required String createdAt,
    required String updatedAt,
    required String status,
  }) = _QuestionDto;

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);
}
