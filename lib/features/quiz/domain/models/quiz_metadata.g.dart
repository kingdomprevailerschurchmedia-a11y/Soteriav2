// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizMetadata _$QuizMetadataFromJson(Map<String, dynamic> json) =>
    _QuizMetadata(
      title: json['title'] as String,
      description: json['description'] as String?,
      authorId: json['authorId'] as String,
      playCount: (json['playCount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$QuizMetadataToJson(_QuizMetadata instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'authorId': instance.authorId,
      'playCount': instance.playCount,
      'rating': instance.rating,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
