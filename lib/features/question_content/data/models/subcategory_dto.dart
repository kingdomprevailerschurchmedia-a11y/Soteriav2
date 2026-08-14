import 'package:freezed_annotation/freezed_annotation.dart';

part 'subcategory_dto.freezed.dart';
part 'subcategory_dto.g.dart';

@freezed
abstract class SubcategoryDto with _$SubcategoryDto {
  const factory SubcategoryDto({
    required String id,
    required String categoryId,
    required String name,
    required String description,
    required String slug,
    @Default(0) int displayOrder,
    @Default(true) bool active,
    @Default({}) Map<String, dynamic> metadata,
    String? createdAt,
    String? updatedAt,
  }) = _SubcategoryDto;

  factory SubcategoryDto.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryDtoFromJson(json);
}
