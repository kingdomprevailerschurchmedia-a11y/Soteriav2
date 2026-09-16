// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_mission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissionDefinition _$MissionDefinitionFromJson(Map<String, dynamic> json) =>
    _MissionDefinition(
      id: json['id'] as String,
      type: $enumDecode(_$MissionTypeEnumMap, json['type']),
      period: $enumDecode(_$MissionPeriodEnumMap, json['period']),
      title: json['title'] as String,
      description: json['description'] as String,
      target: (json['target'] as num).toDouble(),
      difficulty: $enumDecode(_$MissionDifficultyEnumMap, json['difficulty']),
      rewardType: $enumDecode(_$RewardTypeEnumMap, json['rewardType']),
      rewardAmount: (json['rewardAmount'] as num).toInt(),
      categoryId: json['categoryId'] as String?,
      seasonId: json['seasonId'] as String?,
      eventId: json['eventId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$MissionDefinitionToJson(_MissionDefinition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MissionTypeEnumMap[instance.type]!,
      'period': _$MissionPeriodEnumMap[instance.period]!,
      'title': instance.title,
      'description': instance.description,
      'target': instance.target,
      'difficulty': _$MissionDifficultyEnumMap[instance.difficulty]!,
      'rewardType': _$RewardTypeEnumMap[instance.rewardType]!,
      'rewardAmount': instance.rewardAmount,
      'categoryId': instance.categoryId,
      'seasonId': instance.seasonId,
      'eventId': instance.eventId,
      'metadata': instance.metadata,
      'icon': instance.icon,
    };

const _$MissionTypeEnumMap = {
  MissionType.playMatches: 'playMatches',
  MissionType.winMatches: 'winMatches',
  MissionType.answerQuestions: 'answerQuestions',
  MissionType.completeCategory: 'completeCategory',
  MissionType.achieveScore: 'achieveScore',
  MissionType.winStreak: 'winStreak',
  MissionType.completeEvent: 'completeEvent',
  MissionType.earnXp: 'earnXp',
  MissionType.earnRp: 'earnRp',
  MissionType.improveAccuracy: 'improveAccuracy',
};

const _$MissionPeriodEnumMap = {
  MissionPeriod.daily: 'daily',
  MissionPeriod.weekly: 'weekly',
  MissionPeriod.seasonal: 'seasonal',
  MissionPeriod.career: 'career',
};

const _$MissionDifficultyEnumMap = {
  MissionDifficulty.easy: 'easy',
  MissionDifficulty.medium: 'medium',
  MissionDifficulty.hard: 'hard',
};

const _$RewardTypeEnumMap = {
  RewardType.xp: 'xp',
  RewardType.coins: 'coins',
  RewardType.tokens: 'tokens',
  RewardType.badge: 'badge',
  RewardType.achievement: 'achievement',
  RewardType.cosmetic: 'cosmetic',
  RewardType.title: 'title',
};

_UserMissionState _$UserMissionStateFromJson(Map<String, dynamic> json) =>
    _UserMissionState(
      userId: json['userId'] as String,
      missionId: json['missionId'] as String,
      progress: (json['progress'] as num).toDouble(),
      status: $enumDecode(_$MissionStatusEnumMap, json['status']),
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      claimedAt: json['claimedAt'] == null
          ? null
          : DateTime.parse(json['claimedAt'] as String),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$UserMissionStateToJson(_UserMissionState instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'missionId': instance.missionId,
      'progress': instance.progress,
      'status': _$MissionStatusEnumMap[instance.status]!,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'claimedAt': instance.claimedAt?.toIso8601String(),
      'schemaVersion': instance.schemaVersion,
    };

const _$MissionStatusEnumMap = {
  MissionStatus.active: 'active',
  MissionStatus.completed: 'completed',
  MissionStatus.expired: 'expired',
  MissionStatus.locked: 'locked',
  MissionStatus.claimed: 'claimed',
};

_CompetitiveMission _$CompetitiveMissionFromJson(Map<String, dynamic> json) =>
    _CompetitiveMission(
      definition: MissionDefinition.fromJson(
        json['definition'] as Map<String, dynamic>,
      ),
      state: UserMissionState.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompetitiveMissionToJson(_CompetitiveMission instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'state': instance.state,
    };
