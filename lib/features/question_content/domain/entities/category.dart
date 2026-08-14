import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
abstract class Category with _$Category {
  const factory Category({
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
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Category;
}
