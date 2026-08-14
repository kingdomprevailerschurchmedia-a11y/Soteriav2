import 'package:freezed_annotation/freezed_annotation.dart';

part 'subcategory.freezed.dart';

@freezed
abstract class Subcategory with _$Subcategory {
  const factory Subcategory({
    required String id,
    required String categoryId,
    required String name,
    required String description,
    required String slug,
    @Default(0) int displayOrder,
    @Default(true) bool active,
    @Default({}) Map<String, dynamic> metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Subcategory;
}
