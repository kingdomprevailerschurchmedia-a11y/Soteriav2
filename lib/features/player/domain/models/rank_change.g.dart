// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_change.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankChange _$RankChangeFromJson(Map<String, dynamic> json) => _RankChange(
  changeId: json['changeId'] as String,
  userId: json['userId'] as String,
  seasonId: json['seasonId'] as String,
  previousRank: json['previousRank'] as String,
  newRank: json['newRank'] as String,
  previousRankPoints: (json['previousRankPoints'] as num).toInt(),
  newRankPoints: (json['newRankPoints'] as num).toInt(),
  changeAmount: (json['changeAmount'] as num).toInt(),
  type: $enumDecode(_$RankChangeTypeEnumMap, json['type']),
  referenceResultId: json['referenceResultId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
  acknowledged: json['acknowledged'] as bool? ?? false,
  isTierChange: json['isTierChange'] as bool? ?? false,
  isDivisionChange: json['isDivisionChange'] as bool? ?? false,
);

Map<String, dynamic> _$RankChangeToJson(_RankChange instance) =>
    <String, dynamic>{
      'changeId': instance.changeId,
      'userId': instance.userId,
      'seasonId': instance.seasonId,
      'previousRank': instance.previousRank,
      'newRank': instance.newRank,
      'previousRankPoints': instance.previousRankPoints,
      'newRankPoints': instance.newRankPoints,
      'changeAmount': instance.changeAmount,
      'type': _$RankChangeTypeEnumMap[instance.type]!,
      'referenceResultId': instance.referenceResultId,
      'createdAt': instance.createdAt.toIso8601String(),
      'schemaVersion': instance.schemaVersion,
      'acknowledged': instance.acknowledged,
      'isTierChange': instance.isTierChange,
      'isDivisionChange': instance.isDivisionChange,
    };

const _$RankChangeTypeEnumMap = {
  RankChangeType.increase: 'increase',
  RankChangeType.decrease: 'decrease',
  RankChangeType.promotion: 'promotion',
  RankChangeType.demotion: 'demotion',
  RankChangeType.divisionPromotion: 'divisionPromotion',
  RankChangeType.divisionDemotion: 'divisionDemotion',
  RankChangeType.placement: 'placement',
  RankChangeType.seasonReset: 'seasonReset',
  RankChangeType.protection: 'protection',
};
