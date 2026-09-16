// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RewardTransaction _$RewardTransactionFromJson(Map<String, dynamic> json) =>
    _RewardTransaction(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$RewardTypeEnumMap, json['type']),
      transactionType: $enumDecode(
        _$WalletTransactionTypeEnumMap,
        json['transactionType'],
      ),
      direction: $enumDecode(_$TransactionDirectionEnumMap, json['direction']),
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String? ?? 'coins',
      source: $enumDecode(_$RewardSourceEnumMap, json['source']),
      referenceId: json['referenceId'] as String?,
      status:
          $enumDecodeNullable(_$TransactionStatusEnumMap, json['status']) ??
          TransactionStatus.completed,
      createdAt: DateTime.parse(json['createdAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$RewardTransactionToJson(
  _RewardTransaction instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'type': _$RewardTypeEnumMap[instance.type]!,
  'transactionType': _$WalletTransactionTypeEnumMap[instance.transactionType]!,
  'direction': _$TransactionDirectionEnumMap[instance.direction]!,
  'amount': instance.amount,
  'currency': instance.currency,
  'source': _$RewardSourceEnumMap[instance.source]!,
  'referenceId': instance.referenceId,
  'status': _$TransactionStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
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

const _$WalletTransactionTypeEnumMap = {
  WalletTransactionType.purchase: 'purchase',
  WalletTransactionType.gameEntry: 'gameEntry',
  WalletTransactionType.tournamentEntry: 'tournamentEntry',
  WalletTransactionType.reward: 'reward',
  WalletTransactionType.refund: 'refund',
  WalletTransactionType.adminGrant: 'adminGrant',
  WalletTransactionType.promotion: 'promotion',
  WalletTransactionType.spend: 'spend',
  WalletTransactionType.itemRedemption: 'itemRedemption',
  WalletTransactionType.unknown: 'unknown',
};

const _$TransactionDirectionEnumMap = {
  TransactionDirection.credit: 'credit',
  TransactionDirection.debit: 'debit',
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

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.completed: 'completed',
  TransactionStatus.failed: 'failed',
  TransactionStatus.cancelled: 'cancelled',
};
