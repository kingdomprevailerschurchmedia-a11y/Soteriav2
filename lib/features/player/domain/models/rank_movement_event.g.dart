// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_movement_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankMovementEvent _$RankMovementEventFromJson(Map<String, dynamic> json) =>
    _RankMovementEvent(
      id: json['id'] as String,
      userId: json['userId'] as String,
      seasonId: json['seasonId'] as String?,
      previousPosition: (json['previousPosition'] as num).toInt(),
      currentPosition: (json['currentPosition'] as num).toInt(),
      positionDelta: (json['positionDelta'] as num).toInt(),
      previousRank: json['previousRank'] as String,
      currentRank: json['currentRank'] as String,
      rankPoints: (json['rankPoints'] as num).toInt(),
      type: $enumDecode(_$RankMovementTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      sourceId: json['sourceId'] as String?,
    );

Map<String, dynamic> _$RankMovementEventToJson(_RankMovementEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'seasonId': instance.seasonId,
      'previousPosition': instance.previousPosition,
      'currentPosition': instance.currentPosition,
      'positionDelta': instance.positionDelta,
      'previousRank': instance.previousRank,
      'currentRank': instance.currentRank,
      'rankPoints': instance.rankPoints,
      'type': _$RankMovementTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'sourceId': instance.sourceId,
    };

const _$RankMovementTypeEnumMap = {
  RankMovementType.positionImproved: 'positionImproved',
  RankMovementType.positionDropped: 'positionDropped',
  RankMovementType.positionMaintained: 'positionMaintained',
  RankMovementType.rankPromoted: 'rankPromoted',
  RankMovementType.rankDemoted: 'rankDemoted',
  RankMovementType.initialPlacement: 'initialPlacement',
};
