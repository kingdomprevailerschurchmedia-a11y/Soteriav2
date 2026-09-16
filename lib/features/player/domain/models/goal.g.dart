// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalDefinition _$GoalDefinitionFromJson(Map<String, dynamic> json) =>
    _GoalDefinition(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$GoalTypeEnumMap, json['type']),
      category: $enumDecode(_$GoalCategoryEnumMap, json['category']),
      target: (json['target'] as num).toDouble(),
      icon: json['icon'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      rewardType: $enumDecodeNullable(_$RewardTypeEnumMap, json['rewardType']),
      rewardAmount: (json['rewardAmount'] as num?)?.toInt(),
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GoalDefinitionToJson(_GoalDefinition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$GoalTypeEnumMap[instance.type]!,
      'category': _$GoalCategoryEnumMap[instance.category]!,
      'target': instance.target,
      'icon': instance.icon,
      'isActive': instance.isActive,
      'metadata': instance.metadata,
      'rewardType': _$RewardTypeEnumMap[instance.rewardType],
      'rewardAmount': instance.rewardAmount,
      'displayOrder': instance.displayOrder,
    };

const _$GoalTypeEnumMap = {
  GoalType.daily: 'daily',
  GoalType.weekly: 'weekly',
  GoalType.seasonal: 'seasonal',
  GoalType.career: 'career',
};

const _$GoalCategoryEnumMap = {
  GoalCategory.win: 'win',
  GoalCategory.gameCount: 'gameCount',
  GoalCategory.rank: 'rank',
  GoalCategory.score: 'score',
  GoalCategory.streak: 'streak',
  GoalCategory.achievement: 'achievement',
  GoalCategory.personalBest: 'personalBest',
  GoalCategory.correctAnswers: 'correctAnswers',
  GoalCategory.xpEarned: 'xpEarned',
  GoalCategory.practiceCount: 'practiceCount',
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

_PlayerGoal _$PlayerGoalFromJson(Map<String, dynamic> json) => _PlayerGoal(
  userId: json['userId'] as String,
  goalId: json['goalId'] as String,
  status: $enumDecode(_$GoalStatusEnumMap, json['status']),
  currentProgress: (json['currentProgress'] as num).toDouble(),
  startedAt: DateTime.parse(json['startedAt'] as String),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  claimedAt: json['claimedAt'] == null
      ? null
      : DateTime.parse(json['claimedAt'] as String),
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$PlayerGoalToJson(_PlayerGoal instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'goalId': instance.goalId,
      'status': _$GoalStatusEnumMap[instance.status]!,
      'currentProgress': instance.currentProgress,
      'startedAt': instance.startedAt.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'claimedAt': instance.claimedAt?.toIso8601String(),
      'schemaVersion': instance.schemaVersion,
    };

const _$GoalStatusEnumMap = {
  GoalStatus.locked: 'locked',
  GoalStatus.active: 'active',
  GoalStatus.completed: 'completed',
  GoalStatus.expired: 'expired',
  GoalStatus.claimed: 'claimed',
};
