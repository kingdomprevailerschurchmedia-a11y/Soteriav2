import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.freezed.dart';

@freezed
abstract class Topic with _$Topic {
  const factory Topic({
    required String id,
    required String subcategoryId,
    required String name,
    required String description,
    required String slug,
    @Default(0) int displayOrder,
    @Default(true) bool active,
    @Default({}) Map<String, dynamic> metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Topic;
}
