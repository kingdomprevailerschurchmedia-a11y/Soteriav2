import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_dto.freezed.dart';
part 'category_dto.g.dart';

@freezed
abstract class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required String id,
    required String name,
    required String description,
    required String slug,
    required String icon,
    String? image,
    @Default(0) int displayOrder,
    @Default(true) bool active,
    @Default(false) bool featured,
    @Default(1) int minLevel,
    @Default(false) bool isPremium,
    @Default([]) List<String> tags,
    int? questionCount,
    @Default({}) Map<String, dynamic> metadata,
    String? createdAt,
    String? updatedAt,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);
}
