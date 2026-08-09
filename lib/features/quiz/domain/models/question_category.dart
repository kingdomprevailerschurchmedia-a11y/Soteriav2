import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_category.freezed.dart';
part 'question_category.g.dart';

@freezed
abstract class QuestionCategory with _$QuestionCategory {
  const factory QuestionCategory({
    required String id,
    required String name,
    required String icon,
    String? description,
    @Default([]) List<String> tags,
  }) = _QuestionCategory;

  factory QuestionCategory.fromJson(Map<String, dynamic> json) =>
      _$QuestionCategoryFromJson(json);
}
