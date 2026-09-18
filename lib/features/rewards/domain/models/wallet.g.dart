// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wallet _$WalletFromJson(Map<String, dynamic> json) => _Wallet(
  userId: json['userId'] as String,
  coins: (json['coins'] as num?)?.toInt() ?? 0,
  withdrawableCoins: (json['withdrawableCoins'] as num?)?.toInt() ?? 0,
  tokens: (json['tokens'] as num?)?.toInt() ?? 0,
  lifetimeCoinsEarned: (json['lifetimeCoinsEarned'] as num?)?.toInt() ?? 0,
  lifetimeCoinsSpent: (json['lifetimeCoinsSpent'] as num?)?.toInt() ?? 0,
  lifetimeTokensEarned: (json['lifetimeTokensEarned'] as num?)?.toInt() ?? 0,
  lifetimeTokensSpent: (json['lifetimeTokensSpent'] as num?)?.toInt() ?? 0,
  isPro: json['isPro'] as bool? ?? false,
  proExpiresAt: json['proExpiresAt'] == null
      ? null
      : DateTime.parse(json['proExpiresAt'] as String),
  lastTransactionId: json['lastTransactionId'] as String?,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$WalletToJson(_Wallet instance) => <String, dynamic>{
  'userId': instance.userId,
  'coins': instance.coins,
  'withdrawableCoins': instance.withdrawableCoins,
  'tokens': instance.tokens,
  'lifetimeCoinsEarned': instance.lifetimeCoinsEarned,
  'lifetimeCoinsSpent': instance.lifetimeCoinsSpent,
  'lifetimeTokensEarned': instance.lifetimeTokensEarned,
  'lifetimeTokensSpent': instance.lifetimeTokensSpent,
  'isPro': instance.isPro,
  'proExpiresAt': instance.proExpiresAt?.toIso8601String(),
  'lastTransactionId': instance.lastTransactionId,
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
