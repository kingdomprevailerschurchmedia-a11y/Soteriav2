// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopicDto _$TopicDtoFromJson(Map<String, dynamic> json) => _TopicDto(
  id: json['id'] as String,
  subcategoryId: json['subcategoryId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  slug: json['slug'] as String,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? true,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$TopicDtoToJson(_TopicDto instance) => <String, dynamic>{
  'id': instance.id,
  'subcategoryId': instance.subcategoryId,
  'name': instance.name,
  'description': instance.description,
  'slug': instance.slug,
  'displayOrder': instance.displayOrder,
  'active': instance.active,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
