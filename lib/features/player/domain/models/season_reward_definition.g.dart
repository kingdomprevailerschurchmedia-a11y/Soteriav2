// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_reward_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeasonRewardDefinition _$SeasonRewardDefinitionFromJson(
  Map<String, dynamic> json,
) => _SeasonRewardDefinition(
  rewardId: json['rewardId'] as String,
  seasonId: json['seasonId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$RewardTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  isActive: json['isActive'] as bool? ?? true,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  minimumPosition: (json['minimumPosition'] as num?)?.toInt(),
  maximumPosition: (json['maximumPosition'] as num?)?.toInt(),
  minimumRank: json['minimumRank'] as String?,
  minimumTier: (json['minimumTier'] as num?)?.toInt(),
  minimumDivision: (json['minimumDivision'] as num?)?.toInt(),
  participationRequired: json['participationRequired'] as bool?,
);

Map<String, dynamic> _$SeasonRewardDefinitionToJson(
  _SeasonRewardDefinition instance,
) => <String, dynamic>{
  'rewardId': instance.rewardId,
  'seasonId': instance.seasonId,
  'name': instance.name,
  'description': instance.description,
  'type': _$RewardTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'minimumPosition': instance.minimumPosition,
  'maximumPosition': instance.maximumPosition,
  'minimumRank': instance.minimumRank,
  'minimumTier': instance.minimumTier,
  'minimumDivision': instance.minimumDivision,
  'participationRequired': instance.participationRequired,
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
