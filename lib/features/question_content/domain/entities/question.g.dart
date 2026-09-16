// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  id: json['id'] as String,
  text: json['text'] as String,
  explanation: json['explanation'] as String?,
  difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
  categoryId: json['categoryId'] as String,
  subcategoryId: json['subcategoryId'] as String?,
  topicId: json['topicId'] as String?,
  type: $enumDecode(_$QuestionTypeEnumMap, json['type']),
  options: (json['options'] as List<dynamic>)
      .map((e) => Answer.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctOptionIds: (json['correctOptionIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  language: json['language'] as String? ?? 'en',
  estimatedTime: json['estimatedTime'] == null
      ? const Duration(seconds: 30)
      : const DurationConverter().fromJson(
          (json['estimatedTime'] as num).toInt(),
        ),
  xpValue: (json['xpValue'] as num?)?.toInt() ?? 10,
  coinValue: (json['coinValue'] as num?)?.toInt() ?? 5,
  status:
      $enumDecodeNullable(_$QuestionStatusEnumMap, json['status']) ??
      QuestionStatus.draft,
  version: json['version'] as String? ?? '1.0.0',
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  author: json['author'] as String?,
  source: json['source'] as String,
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
  contentHash: json['contentHash'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'explanation': instance.explanation,
  'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
  'categoryId': instance.categoryId,
  'subcategoryId': instance.subcategoryId,
  'topicId': instance.topicId,
  'type': _$QuestionTypeEnumMap[instance.type]!,
  'options': instance.options.map((e) => e.toJson()).toList(),
  'correctOptionIds': instance.correctOptionIds,
  'tags': instance.tags,
  'language': instance.language,
  'estimatedTime': const DurationConverter().toJson(instance.estimatedTime),
  'xpValue': instance.xpValue,
  'coinValue': instance.coinValue,
  'status': _$QuestionStatusEnumMap[instance.status]!,
  'version': instance.version,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'author': instance.author,
  'source': instance.source,
  'schemaVersion': instance.schemaVersion,
  'contentHash': instance.contentHash,
  'metadata': instance.metadata,
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};

const _$QuestionTypeEnumMap = {
  QuestionType.multipleChoice: 'multipleChoice',
  QuestionType.trueFalse: 'trueFalse',
  QuestionType.multipleSelect: 'multipleSelect',
  QuestionType.image: 'image',
  QuestionType.audio: 'audio',
  QuestionType.video: 'video',
  QuestionType.fillInBlank: 'fillInBlank',
  QuestionType.ordering: 'ordering',
  QuestionType.matching: 'matching',
};

const _$QuestionStatusEnumMap = {
  QuestionStatus.draft: 'draft',
  QuestionStatus.review: 'review',
  QuestionStatus.approved: 'approved',
  QuestionStatus.published: 'published',
  QuestionStatus.archived: 'archived',
  QuestionStatus.rejected: 'rejected',
};

_Answer _$AnswerFromJson(Map<String, dynamic> json) => _Answer(
  id: json['id'] as String,
  text: json['text'] as String,
  mediaUrl: json['mediaUrl'] as String?,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AnswerToJson(_Answer instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'mediaUrl': instance.mediaUrl,
  'displayOrder': instance.displayOrder,
};
