// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) =>
    _WalletTransaction(
      id: json['id'] as String,
      uid: json['uid'] as String,
      direction: json['direction'] as String,
      amount: (json['amount'] as num).toInt(),
      balanceBefore: (json['balanceBefore'] as num).toInt(),
      balanceAfter: (json['balanceAfter'] as num).toInt(),
      type: $enumDecode(_$WalletTransactionTypeEnumMap, json['type']),
      referenceId: json['referenceId'] as String?,
      idempotencyKey: json['idempotencyKey'] as String,
      status: json['status'] as String? ?? 'completed',
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: const RequiredTimestampConverter().fromJson(json['createdAt']),
      processedAt: const TimestampConverter().fromJson(json['processedAt']),
    );

Map<String, dynamic> _$WalletTransactionToJson(
  _WalletTransaction instance,
) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'direction': instance.direction,
  'amount': instance.amount,
  'balanceBefore': instance.balanceBefore,
  'balanceAfter': instance.balanceAfter,
  'type': _$WalletTransactionTypeEnumMap[instance.type]!,
  'referenceId': instance.referenceId,
  'idempotencyKey': instance.idempotencyKey,
  'status': instance.status,
  'metadata': instance.metadata,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'processedAt': const TimestampConverter().toJson(instance.processedAt),
};

const _$WalletTransactionTypeEnumMap = {
  WalletTransactionType.coinPurchase: 'coinPurchase',
  WalletTransactionType.proModeEntry: 'proModeEntry',
  WalletTransactionType.tournamentEntry: 'tournamentEntry',
  WalletTransactionType.tournamentReward: 'tournamentReward',
  WalletTransactionType.achievementReward: 'achievementReward',
  WalletTransactionType.streakReward: 'streakReward',
  WalletTransactionType.bonus: 'bonus',
  WalletTransactionType.refund: 'refund',
  WalletTransactionType.adminAdjustment: 'adminAdjustment',
  WalletTransactionType.withdrawal: 'withdrawal',
  WalletTransactionType.withdrawalReversal: 'withdrawalReversal',
};
