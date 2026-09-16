// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => _QuestionDto(
  id: json['id'] as String,
  text: json['text'] as String,
  explanation: json['explanation'] as String?,
  difficulty: json['difficulty'] as String,
  categoryId: json['categoryId'] as String,
  subcategoryId: json['subcategoryId'] as String?,
  topicId: json['topicId'] as String?,
  type: json['type'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => AnswerDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctOptionIds: (json['correctOptionIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  language: json['language'] as String? ?? 'en',
  estimatedTimeSeconds: (json['estimatedTimeSeconds'] as num?)?.toInt() ?? 30,
  xpValue: (json['xpValue'] as num?)?.toInt() ?? 10,
  coinValue: (json['coinValue'] as num?)?.toInt() ?? 5,
  status: json['status'] as String? ?? 'draft',
  version: json['version'] as String? ?? '1.0.0',
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  author: json['author'] as String?,
  source: json['source'] as String,
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
  contentHash: json['contentHash'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$QuestionDtoToJson(_QuestionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'explanation': instance.explanation,
      'difficulty': instance.difficulty,
      'categoryId': instance.categoryId,
      'subcategoryId': instance.subcategoryId,
      'topicId': instance.topicId,
      'type': instance.type,
      'options': instance.options,
      'correctOptionIds': instance.correctOptionIds,
      'tags': instance.tags,
      'language': instance.language,
      'estimatedTimeSeconds': instance.estimatedTimeSeconds,
      'xpValue': instance.xpValue,
      'coinValue': instance.coinValue,
      'status': instance.status,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'author': instance.author,
      'source': instance.source,
      'schemaVersion': instance.schemaVersion,
      'contentHash': instance.contentHash,
      'metadata': instance.metadata,
    };

_AnswerDto _$AnswerDtoFromJson(Map<String, dynamic> json) => _AnswerDto(
  id: json['id'] as String,
  text: json['text'] as String,
  mediaUrl: json['mediaUrl'] as String?,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AnswerDtoToJson(_AnswerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'mediaUrl': instance.mediaUrl,
      'displayOrder': instance.displayOrder,
    };
