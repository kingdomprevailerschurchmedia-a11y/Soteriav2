// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wallet _$WalletFromJson(Map<String, dynamic> json) => _Wallet(
  uid: json['uid'] as String,
  balance: (json['balance'] as num?)?.toInt() ?? 0,
  lastTransactionId: json['lastTransactionId'] as String?,
  updatedAt: const RequiredTimestampConverter().fromJson(json['updatedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$WalletToJson(_Wallet instance) => <String, dynamic>{
  'uid': instance.uid,
  'balance': instance.balance,
  'lastTransactionId': instance.lastTransactionId,
  'updatedAt': const RequiredTimestampConverter().toJson(instance.updatedAt),
  'version': instance.version,
};
