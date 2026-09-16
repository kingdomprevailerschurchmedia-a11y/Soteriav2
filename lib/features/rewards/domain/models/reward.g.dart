// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reward _$RewardFromJson(Map<String, dynamic> json) => _Reward(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$RewardTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  source: $enumDecode(_$RewardSourceEnumMap, json['source']),
  status:
      $enumDecodeNullable(_$RewardStatusEnumMap, json['status']) ??
      RewardStatus.available,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  claimedAt: json['claimedAt'] == null
      ? null
      : DateTime.parse(json['claimedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$RewardToJson(_Reward instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': _$RewardTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'source': _$RewardSourceEnumMap[instance.source]!,
  'status': _$RewardStatusEnumMap[instance.status]!,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'claimedAt': instance.claimedAt?.toIso8601String(),
  'metadata': instance.metadata,
};

const _$RewardTypeEnumMap = {
  RewardType.coins: 'coins',
  RewardType.tokens: 'tokens',
  RewardType.xp: 'xp',
  RewardType.ticket: 'ticket',
  RewardType.premiumCurrency: 'premiumCurrency',
  RewardType.cosmetic: 'cosmetic',
  RewardType.item: 'item',
  RewardType.boost: 'boost',
  RewardType.mysteryChest: 'mysteryChest',
};

const _$RewardSourceEnumMap = {
  RewardSource.dailyLogin: 'dailyLogin',
  RewardSource.dailyChallenge: 'dailyChallenge',
  RewardSource.achievement: 'achievement',
  RewardSource.milestone: 'milestone',
  RewardSource.streak: 'streak',
  RewardSource.tournament: 'tournament',
  RewardSource.tournamentReward: 'tournamentReward',
  RewardSource.proModeEntry: 'proModeEntry',
  RewardSource.proModeReward: 'proModeReward',
  RewardSource.practice: 'practice',
  RewardSource.goalCompletion: 'goalCompletion',
  RewardSource.competitiveReward: 'competitiveReward',
  RewardSource.itemRedemption: 'itemRedemption',
  RewardSource.season: 'season',
  RewardSource.rank: 'rank',
  RewardSource.event: 'event',
  RewardSource.promotion: 'promotion',
  RewardSource.purchase: 'purchase',
  RewardSource.purchaseBonus: 'purchaseBonus',
  RewardSource.gameEntry: 'gameEntry',
  RewardSource.tournamentEntry: 'tournamentEntry',
  RewardSource.refund: 'refund',
  RewardSource.adminGrant: 'adminGrant',
  RewardSource.unknown: 'unknown',
};

const _$RewardStatusEnumMap = {
  RewardStatus.locked: 'locked',
  RewardStatus.available: 'available',
  RewardStatus.claimable: 'claimable',
  RewardStatus.claimed: 'claimed',
  RewardStatus.expired: 'expired',
};
