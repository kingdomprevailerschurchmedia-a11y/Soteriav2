// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeasonResult _$SeasonResultFromJson(Map<String, dynamic> json) =>
    _SeasonResult(
      seasonId: json['seasonId'] as String,
      userId: json['userId'] as String,
      seasonName: json['seasonName'] as String,
      seasonNumber: (json['seasonNumber'] as num).toInt(),
      finalPosition: (json['finalPosition'] as num).toInt(),
      finalRankPoints: (json['finalRankPoints'] as num).toInt(),
      finalTier: json['finalTier'] as String,
      finalDivision: (json['finalDivision'] as num).toInt(),
      previousTier: json['previousTier'] as String,
      previousDivision: (json['previousDivision'] as num).toInt(),
      rankChange: (json['rankChange'] as num).toInt(),
      completedAt: DateTime.parse(json['completedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as String? ?? 'finalized',
      statistics: json['statistics'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SeasonResultToJson(_SeasonResult instance) =>
    <String, dynamic>{
      'seasonId': instance.seasonId,
      'userId': instance.userId,
      'seasonName': instance.seasonName,
      'seasonNumber': instance.seasonNumber,
      'finalPosition': instance.finalPosition,
      'finalRankPoints': instance.finalRankPoints,
      'finalTier': instance.finalTier,
      'finalDivision': instance.finalDivision,
      'previousTier': instance.previousTier,
      'previousDivision': instance.previousDivision,
      'rankChange': instance.rankChange,
      'completedAt': instance.completedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'status': instance.status,
      'statistics': instance.statistics,
    };

_CompetitiveHistory _$CompetitiveHistoryFromJson(Map<String, dynamic> json) =>
    _CompetitiveHistory(
      userId: json['userId'] as String,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => SeasonResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      bestResult: json['bestResult'] == null
          ? null
          : SeasonResult.fromJson(json['bestResult'] as Map<String, dynamic>),
      latestResult: json['latestResult'] == null
          ? null
          : SeasonResult.fromJson(json['latestResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompetitiveHistoryToJson(_CompetitiveHistory instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'results': instance.results,
      'bestResult': instance.bestResult,
      'latestResult': instance.latestResult,
    };
