// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => _CategoryDto(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  slug: json['slug'] as String,
  icon: json['icon'] as String,
  image: json['image'] as String?,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? true,
  featured: json['featured'] as bool? ?? false,
  minLevel: (json['minLevel'] as num?)?.toInt() ?? 1,
  isPremium: json['isPremium'] as bool? ?? false,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  questionCount: (json['questionCount'] as num?)?.toInt(),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$CategoryDtoToJson(_CategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'slug': instance.slug,
      'icon': instance.icon,
      'image': instance.image,
      'displayOrder': instance.displayOrder,
      'active': instance.active,
      'featured': instance.featured,
      'minLevel': instance.minLevel,
      'isPremium': instance.isPremium,
      'tags': instance.tags,
      'questionCount': instance.questionCount,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
