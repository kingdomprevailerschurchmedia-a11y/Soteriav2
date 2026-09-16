// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MilestoneDefinition _$MilestoneDefinitionFromJson(Map<String, dynamic> json) =>
    _MilestoneDefinition(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$MilestoneTypeEnumMap, json['type']),
      category: $enumDecode(_$MilestoneCategoryEnumMap, json['category']),
      threshold: (json['threshold'] as num).toDouble(),
      icon: json['icon'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      rewardType: $enumDecodeNullable(_$RewardTypeEnumMap, json['rewardType']),
      rewardAmount: (json['rewardAmount'] as num?)?.toInt(),
      achievementId: json['achievementId'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MilestoneDefinitionToJson(
  _MilestoneDefinition instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'type': _$MilestoneTypeEnumMap[instance.type]!,
  'category': _$MilestoneCategoryEnumMap[instance.category]!,
  'threshold': instance.threshold,
  'icon': instance.icon,
  'isActive': instance.isActive,
  'metadata': instance.metadata,
  'rewardType': _$RewardTypeEnumMap[instance.rewardType],
  'rewardAmount': instance.rewardAmount,
  'achievementId': instance.achievementId,
  'displayOrder': instance.displayOrder,
};

const _$MilestoneTypeEnumMap = {
  MilestoneType.count: 'count',
  MilestoneType.win: 'win',
  MilestoneType.streak: 'streak',
  MilestoneType.rank: 'rank',
  MilestoneType.position: 'position',
  MilestoneType.season: 'season',
  MilestoneType.statistic: 'statistic',
  MilestoneType.careerBest: 'careerBest',
  MilestoneType.promotion: 'promotion',
  MilestoneType.welcome: 'welcome',
};

const _$MilestoneCategoryEnumMap = {
  MilestoneCategory.general: 'general',
  MilestoneCategory.participation: 'participation',
  MilestoneCategory.victory: 'victory',
  MilestoneCategory.ranking: 'ranking',
  MilestoneCategory.social: 'social',
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

_PlayerMilestone _$PlayerMilestoneFromJson(Map<String, dynamic> json) =>
    _PlayerMilestone(
      userId: json['userId'] as String,
      milestoneId: json['milestoneId'] as String,
      status: $enumDecode(_$MilestoneStatusEnumMap, json['status']),
      currentProgress: (json['currentProgress'] as num).toDouble(),
      unlockedAt: const TimestampConverter().fromJson(json['unlockedAt']),
      claimedAt: const TimestampConverter().fromJson(json['claimedAt']),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$PlayerMilestoneToJson(_PlayerMilestone instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'milestoneId': instance.milestoneId,
      'status': _$MilestoneStatusEnumMap[instance.status]!,
      'currentProgress': instance.currentProgress,
      'unlockedAt': const TimestampConverter().toJson(instance.unlockedAt),
      'claimedAt': const TimestampConverter().toJson(instance.claimedAt),
      'schemaVersion': instance.schemaVersion,
    };

const _$MilestoneStatusEnumMap = {
  MilestoneStatus.locked: 'locked',
  MilestoneStatus.inProgress: 'inProgress',
  MilestoneStatus.completed: 'completed',
  MilestoneStatus.claimed: 'claimed',
};
