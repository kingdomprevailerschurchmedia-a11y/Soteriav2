// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AchievementDefinition _$AchievementDefinitionFromJson(
  Map<String, dynamic> json,
) => _AchievementDefinition(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  category: $enumDecode(_$AchievementCategoryEnumMap, json['category']),
  icon: json['icon'] as String,
  requirementType: $enumDecode(
    _$AchievementRequirementTypeEnumMap,
    json['requirementType'],
  ),
  threshold: (json['threshold'] as num).toDouble(),
  rarity:
      $enumDecodeNullable(_$AchievementRarityEnumMap, json['rarity']) ??
      AchievementRarity.common,
  xpReward: (json['xpReward'] as num?)?.toInt() ?? 0,
  coinReward: (json['coinReward'] as num?)?.toInt() ?? 0,
  isHidden: json['isHidden'] as bool? ?? false,
  isActive: json['isActive'] as bool? ?? true,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AchievementDefinitionToJson(
  _AchievementDefinition instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category': _$AchievementCategoryEnumMap[instance.category]!,
  'icon': instance.icon,
  'requirementType':
      _$AchievementRequirementTypeEnumMap[instance.requirementType]!,
  'threshold': instance.threshold,
  'rarity': _$AchievementRarityEnumMap[instance.rarity]!,
  'xpReward': instance.xpReward,
  'coinReward': instance.coinReward,
  'isHidden': instance.isHidden,
  'isActive': instance.isActive,
  'metadata': instance.metadata,
  'displayOrder': instance.displayOrder,
};

const _$AchievementCategoryEnumMap = {
  AchievementCategory.general: 'general',
  AchievementCategory.participation: 'participation',
  AchievementCategory.victory: 'victory',
  AchievementCategory.streak: 'streak',
  AchievementCategory.ranking: 'ranking',
  AchievementCategory.social: 'social',
  AchievementCategory.special: 'special',
};

const _$AchievementRequirementTypeEnumMap = {
  AchievementRequirementType.score: 'score',
  AchievementRequirementType.xp: 'xp',
  AchievementRequirementType.level: 'level',
  AchievementRequirementType.streak: 'streak',
  AchievementRequirementType.gamesPlayed: 'gamesPlayed',
  AchievementRequirementType.gamesWon: 'gamesWon',
  AchievementRequirementType.correctAnswers: 'correctAnswers',
  AchievementRequirementType.accuracy: 'accuracy',
  AchievementRequirementType.tournamentWin: 'tournamentWin',
  AchievementRequirementType.proWin: 'proWin',
  AchievementRequirementType.categoryMastery: 'categoryMastery',
  AchievementRequirementType.dailyLoginStreak: 'dailyLoginStreak',
};

const _$AchievementRarityEnumMap = {
  AchievementRarity.common: 'common',
  AchievementRarity.uncommon: 'uncommon',
  AchievementRarity.rare: 'rare',
  AchievementRarity.epic: 'epic',
  AchievementRarity.legendary: 'legendary',
  AchievementRarity.mythic: 'mythic',
};

_PlayerAchievement _$PlayerAchievementFromJson(Map<String, dynamic> json) =>
    _PlayerAchievement(
      userId: json['userId'] as String,
      achievementId: json['achievementId'] as String,
      status: $enumDecode(_$AchievementStatusEnumMap, json['status']),
      currentValue: (json['currentValue'] as num).toDouble(),
      targetValue: (json['targetValue'] as num).toDouble(),
      unlockedAt: const TimestampConverter().fromJson(json['unlockedAt']),
      claimedAt: const TimestampConverter().fromJson(json['claimedAt']),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$PlayerAchievementToJson(_PlayerAchievement instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'achievementId': instance.achievementId,
      'status': _$AchievementStatusEnumMap[instance.status]!,
      'currentValue': instance.currentValue,
      'targetValue': instance.targetValue,
      'unlockedAt': const TimestampConverter().toJson(instance.unlockedAt),
      'claimedAt': const TimestampConverter().toJson(instance.claimedAt),
      'schemaVersion': instance.schemaVersion,
    };

const _$AchievementStatusEnumMap = {
  AchievementStatus.inProgress: 'inProgress',
  AchievementStatus.unlocked: 'unlocked',
  AchievementStatus.claimed: 'claimed',
};
