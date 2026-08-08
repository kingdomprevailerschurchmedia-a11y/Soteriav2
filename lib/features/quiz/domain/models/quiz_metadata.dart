import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_metadata.freezed.dart';
part 'quiz_metadata.g.dart';

@freezed
class QuizMetadata with _$QuizMetadata {
  const factory QuizMetadata({
    required String title,
    String? description,
    required String authorId,
    @Default(0) int playCount,
    @Default(0.0) double rating,
    @Default([]) List<String> tags,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _QuizMetadata;

  factory QuizMetadata.fromJson(Map<String, dynamic> json) =>
      _$QuizMetadataFromJson(json);
}
