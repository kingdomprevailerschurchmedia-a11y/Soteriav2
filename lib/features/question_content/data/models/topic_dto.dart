import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_dto.freezed.dart';
part 'topic_dto.g.dart';

@freezed
abstract class TopicDto with _$TopicDto {
  const factory TopicDto({
    required String id,
    required String subcategoryId,
    required String name,
    required String description,
    required String slug,
    @Default(0) int displayOrder,
    @Default(true) bool active,
    @Default({}) Map<String, dynamic> metadata,
    String? createdAt,
    String? updatedAt,
  }) = _TopicDto;

  factory TopicDto.fromJson(Map<String, dynamic> json) =>
      _$TopicDtoFromJson(json);
}
