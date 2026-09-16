// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankTransaction _$RankTransactionFromJson(Map<String, dynamic> json) =>
    _RankTransaction(
      transactionId: json['transactionId'] as String,
      userId: json['userId'] as String,
      seasonId: json['seasonId'] as String,
      resultId: json['resultId'] as String,
      previousRankPoints: (json['previousRankPoints'] as num).toInt(),
      changeAmount: (json['changeAmount'] as num).toInt(),
      newRankPoints: (json['newRankPoints'] as num).toInt(),
      timestamp: const RequiredTimestampConverter().fromJson(json['timestamp']),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$RankTransactionToJson(
  _RankTransaction instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'userId': instance.userId,
  'seasonId': instance.seasonId,
  'resultId': instance.resultId,
  'previousRankPoints': instance.previousRankPoints,
  'changeAmount': instance.changeAmount,
  'newRankPoints': instance.newRankPoints,
  'timestamp': const RequiredTimestampConverter().toJson(instance.timestamp),
  'schemaVersion': instance.schemaVersion,
};
