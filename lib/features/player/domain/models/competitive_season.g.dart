// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveSeason _$CompetitiveSeasonFromJson(Map<String, dynamic> json) =>
    _CompetitiveSeason(
      seasonId: json['seasonId'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String?,
      status: $enumDecode(_$SeasonStatusEnumMap, json['status']),
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      rankConfigId: json['rankConfigId'] as String?,
      leaderboardId: json['leaderboardId'] as String?,
      description: json['description'] as String?,
      seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
      isCurrent: json['isCurrent'] as bool? ?? false,
      isVisible: json['isVisible'] as bool? ?? true,
      archiveAt: json['archiveAt'] == null
          ? null
          : DateTime.parse(json['archiveAt'] as String),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$CompetitiveSeasonToJson(_CompetitiveSeason instance) =>
    <String, dynamic>{
      'seasonId': instance.seasonId,
      'name': instance.name,
      'displayName': instance.displayName,
      'status': _$SeasonStatusEnumMap[instance.status]!,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'rankConfigId': instance.rankConfigId,
      'leaderboardId': instance.leaderboardId,
      'description': instance.description,
      'seasonNumber': instance.seasonNumber,
      'isCurrent': instance.isCurrent,
      'isVisible': instance.isVisible,
      'archiveAt': instance.archiveAt?.toIso8601String(),
      'version': instance.version,
    };

const _$SeasonStatusEnumMap = {
  SeasonStatus.upcoming: 'upcoming',
  SeasonStatus.active: 'active',
  SeasonStatus.ending: 'ending',
  SeasonStatus.completed: 'completed',
  SeasonStatus.archived: 'archived',
};
