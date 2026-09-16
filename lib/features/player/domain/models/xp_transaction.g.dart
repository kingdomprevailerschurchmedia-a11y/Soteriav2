// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xp_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_XpTransaction _$XpTransactionFromJson(Map<String, dynamic> json) =>
    _XpTransaction(
      transactionId: json['transactionId'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toInt(),
      source: $enumDecode(_$XpSourceEnumMap, json['source']),
      referenceId: json['referenceId'] as String,
      createdAt: const RequiredTimestampConverter().fromJson(json['createdAt']),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$XpTransactionToJson(
  _XpTransaction instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'userId': instance.userId,
  'amount': instance.amount,
  'source': _$XpSourceEnumMap[instance.source]!,
  'referenceId': instance.referenceId,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'schemaVersion': instance.schemaVersion,
};

const _$XpSourceEnumMap = {
  XpSource.quizCompletion: 'quizCompletion',
  XpSource.achievement: 'achievement',
  XpSource.dailyChallenge: 'dailyChallenge',
  XpSource.milestone: 'milestone',
  XpSource.goal: 'goal',
  XpSource.tournament: 'tournament',
  XpSource.versus: 'versus',
  XpSource.bonus: 'bonus',
  XpSource.adminGrant: 'adminGrant',
};
