// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_title.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveTitle _$CompetitiveTitleFromJson(Map<String, dynamic> json) =>
    _CompetitiveTitle(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      isSecret: json['isSecret'] as bool? ?? false,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CompetitiveTitleToJson(_CompetitiveTitle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isSecret': instance.isSecret,
      'priority': instance.priority,
    };
