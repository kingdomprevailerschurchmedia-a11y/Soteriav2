// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveResult _$CompetitiveResultFromJson(
  Map<String, dynamic> json,
) => _CompetitiveResult(
  resultId: json['resultId'] as String,
  userId: json['userId'] as String,
  seasonId: json['seasonId'] as String,
  outcome: $enumDecode(_$CompetitiveOutcomeEnumMap, json['outcome']),
  mode: json['mode'] as String,
  score: (json['score'] as num).toInt(),
  completedAt: const RequiredTimestampConverter().fromJson(json['completedAt']),
  maxStreak: (json['maxStreak'] as num?)?.toInt() ?? 0,
  opponentId: json['opponentId'] as String?,
  performanceModifiers: json['performanceModifiers'] as Map<String, dynamic>?,
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$CompetitiveResultToJson(_CompetitiveResult instance) =>
    <String, dynamic>{
      'resultId': instance.resultId,
      'userId': instance.userId,
      'seasonId': instance.seasonId,
      'outcome': _$CompetitiveOutcomeEnumMap[instance.outcome]!,
      'mode': instance.mode,
      'score': instance.score,
      'completedAt': const RequiredTimestampConverter().toJson(
        instance.completedAt,
      ),
      'maxStreak': instance.maxStreak,
      'opponentId': instance.opponentId,
      'performanceModifiers': instance.performanceModifiers,
      'version': instance.version,
    };

const _$CompetitiveOutcomeEnumMap = {
  CompetitiveOutcome.win: 'win',
  CompetitiveOutcome.loss: 'loss',
  CompetitiveOutcome.draw: 'draw',
  CompetitiveOutcome.placement: 'placement',
};
