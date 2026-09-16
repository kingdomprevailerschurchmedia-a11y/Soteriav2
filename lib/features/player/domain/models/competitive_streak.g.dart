// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_streak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveStreak _$CompetitiveStreakFromJson(Map<String, dynamic> json) =>
    _CompetitiveStreak(
      userId: json['userId'] as String,
      type: $enumDecode(_$StreakTypeEnumMap, json['type']),
      current: (json['current'] as num).toInt(),
      best: (json['best'] as num).toInt(),
      seasonBest: (json['seasonBest'] as num).toInt(),
      startedAt: DateTime.parse(json['startedAt'] as String),
      lastQualifiedAt: DateTime.parse(json['lastQualifiedAt'] as String),
      seasonId: json['seasonId'] as String?,
      status:
          $enumDecodeNullable(_$StreakStatusEnumMap, json['status']) ??
          StreakStatus.active,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CompetitiveStreakToJson(_CompetitiveStreak instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'type': _$StreakTypeEnumMap[instance.type]!,
      'current': instance.current,
      'best': instance.best,
      'seasonBest': instance.seasonBest,
      'startedAt': instance.startedAt.toIso8601String(),
      'lastQualifiedAt': instance.lastQualifiedAt.toIso8601String(),
      'seasonId': instance.seasonId,
      'status': _$StreakStatusEnumMap[instance.status]!,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$StreakTypeEnumMap = {
  StreakType.win: 'win',
  StreakType.participation: 'participation',
  StreakType.performance: 'performance',
  StreakType.personalBest: 'personalBest',
};

const _$StreakStatusEnumMap = {
  StreakStatus.active: 'active',
  StreakStatus.broken: 'broken',
  StreakStatus.milestoneReached: 'milestoneReached',
};
