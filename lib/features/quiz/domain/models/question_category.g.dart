// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionCategory _$QuestionCategoryFromJson(Map<String, dynamic> json) =>
    _QuestionCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$QuestionCategoryToJson(_QuestionCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'description': instance.description,
      'tags': instance.tags,
    };
