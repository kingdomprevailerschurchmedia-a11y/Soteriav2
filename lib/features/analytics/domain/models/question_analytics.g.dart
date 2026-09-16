// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionAnalytics _$QuestionAnalyticsFromJson(Map<String, dynamic> json) =>
    _QuestionAnalytics(
      questionId: json['questionId'] as String,
      version: json['version'] as String,
      categoryId: json['categoryId'] as String,
      difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
      totalAttempts: (json['totalAttempts'] as num?)?.toInt() ?? 0,
      correctAttempts: (json['correctAttempts'] as num?)?.toInt() ?? 0,
      incorrectAttempts: (json['incorrectAttempts'] as num?)?.toInt() ?? 0,
      timeoutCount: (json['timeoutCount'] as num?)?.toInt() ?? 0,
      skipCount: (json['skipCount'] as num?)?.toInt() ?? 0,
      averageResponseTime: json['averageResponseTime'] == null
          ? Duration.zero
          : const DurationConverter().fromJson(
              (json['averageResponseTime'] as num).toInt(),
            ),
      fastestResponseTime: json['fastestResponseTime'] == null
          ? Duration.zero
          : const DurationConverter().fromJson(
              (json['fastestResponseTime'] as num).toInt(),
            ),
      slowestResponseTime: json['slowestResponseTime'] == null
          ? Duration.zero
          : const DurationConverter().fromJson(
              (json['slowestResponseTime'] as num).toInt(),
            ),
      firstAttemptAt: const TimestampConverter().fromJson(
        json['firstAttemptAt'],
      ),
      lastAttemptAt: const TimestampConverter().fromJson(json['lastAttemptAt']),
      modeBreakdown:
          (json['modeBreakdown'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$QuestionAnalyticsToJson(
  _QuestionAnalytics instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'version': instance.version,
  'categoryId': instance.categoryId,
  'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
  'totalAttempts': instance.totalAttempts,
  'correctAttempts': instance.correctAttempts,
  'incorrectAttempts': instance.incorrectAttempts,
  'timeoutCount': instance.timeoutCount,
  'skipCount': instance.skipCount,
  'averageResponseTime': const DurationConverter().toJson(
    instance.averageResponseTime,
  ),
  'fastestResponseTime': const DurationConverter().toJson(
    instance.fastestResponseTime,
  ),
  'slowestResponseTime': const DurationConverter().toJson(
    instance.slowestResponseTime,
  ),
  'firstAttemptAt': const TimestampConverter().toJson(instance.firstAttemptAt),
  'lastAttemptAt': const TimestampConverter().toJson(instance.lastAttemptAt),
  'modeBreakdown': instance.modeBreakdown,
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};
