// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_personal_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitivePersonalRecord _$CompetitivePersonalRecordFromJson(
  Map<String, dynamic> json,
) => _CompetitivePersonalRecord(
  id: json['id'] as String,
  userId: json['userId'] as String,
  type: $enumDecode(_$CompetitiveRecordTypeEnumMap, json['type']),
  value: (json['value'] as num).toDouble(),
  displayValue: json['displayValue'] as String,
  matchId: json['matchId'] as String?,
  seasonId: json['seasonId'] as String?,
  mode: json['mode'] as String?,
  achievedAt: DateTime.parse(json['achievedAt'] as String),
  previousValue: (json['previousValue'] as num?)?.toDouble(),
  isCareerRecord: json['isCareerRecord'] as bool? ?? false,
);

Map<String, dynamic> _$CompetitivePersonalRecordToJson(
  _CompetitivePersonalRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'type': _$CompetitiveRecordTypeEnumMap[instance.type]!,
  'value': instance.value,
  'displayValue': instance.displayValue,
  'matchId': instance.matchId,
  'seasonId': instance.seasonId,
  'mode': instance.mode,
  'achievedAt': instance.achievedAt.toIso8601String(),
  'previousValue': instance.previousValue,
  'isCareerRecord': instance.isCareerRecord,
};

const _$CompetitiveRecordTypeEnumMap = {
  CompetitiveRecordType.highestScore: 'highestScore',
  CompetitiveRecordType.bestAccuracy: 'bestAccuracy',
  CompetitiveRecordType.longestWinStreak: 'longestWinStreak',
  CompetitiveRecordType.mostRankPointsGained: 'mostRankPointsGained',
  CompetitiveRecordType.bestRankReached: 'bestRankReached',
  CompetitiveRecordType.bestLeaderboardPosition: 'bestLeaderboardPosition',
  CompetitiveRecordType.bestSeasonPosition: 'bestSeasonPosition',
  CompetitiveRecordType.mostWinsInSeason: 'mostWinsInSeason',
  CompetitiveRecordType.bestModeScore: 'bestModeScore',
};
