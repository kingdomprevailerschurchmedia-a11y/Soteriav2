// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_grant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RewardGrant _$RewardGrantFromJson(Map<String, dynamic> json) => _RewardGrant(
  grantId: json['grantId'] as String,
  rewardId: json['rewardId'] as String,
  seasonId: json['seasonId'] as String,
  userId: json['userId'] as String,
  type: $enumDecode(_$RewardTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  status: $enumDecode(_$GrantStatusEnumMap, json['status']),
  transactionId: json['transactionId'] as String?,
  grantedAt: const TimestampConverter().fromJson(json['grantedAt']),
  claimedAt: const TimestampConverter().fromJson(json['claimedAt']),
  createdAt: const RequiredTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const RequiredTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$RewardGrantToJson(
  _RewardGrant instance,
) => <String, dynamic>{
  'grantId': instance.grantId,
  'rewardId': instance.rewardId,
  'seasonId': instance.seasonId,
  'userId': instance.userId,
  'type': _$RewardTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'status': _$GrantStatusEnumMap[instance.status]!,
  'transactionId': instance.transactionId,
  'grantedAt': const TimestampConverter().toJson(instance.grantedAt),
  'claimedAt': const TimestampConverter().toJson(instance.claimedAt),
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const RequiredTimestampConverter().toJson(instance.updatedAt),
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

const _$GrantStatusEnumMap = {
  GrantStatus.eligible: 'eligible',
  GrantStatus.pending: 'pending',
  GrantStatus.granted: 'granted',
  GrantStatus.claimed: 'claimed',
  GrantStatus.failed: 'failed',
  GrantStatus.cancelled: 'cancelled',
};
