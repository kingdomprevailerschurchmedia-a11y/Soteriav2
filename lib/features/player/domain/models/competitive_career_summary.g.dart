// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_career_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveCareerSummary _$CompetitiveCareerSummaryFromJson(
  Map<String, dynamic> json,
) => _CompetitiveCareerSummary(
  userId: json['userId'] as String,
  totalSeasons: (json['totalSeasons'] as num).toInt(),
  bestRank: json['bestRank'] as String,
  bestPosition: (json['bestPosition'] as num).toInt(),
  totalMatches: (json['totalMatches'] as num).toInt(),
  totalWins: (json['totalWins'] as num).toInt(),
  totalLosses: (json['totalLosses'] as num).toInt(),
  winRate: (json['winRate'] as num).toDouble(),
  bestStreak: (json['bestStreak'] as num).toInt(),
  highestScore: (json['highestScore'] as num).toInt(),
  totalXp: (json['totalXp'] as num).toInt(),
  bestSeason: json['bestSeason'] == null
      ? null
      : SeasonResult.fromJson(json['bestSeason'] as Map<String, dynamic>),
  careerRecords:
      (json['careerRecords'] as List<dynamic>?)
          ?.map(
            (e) =>
                CompetitivePersonalRecord.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  recentForm:
      (json['recentForm'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$CompetitiveCareerSummaryToJson(
  _CompetitiveCareerSummary instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'totalSeasons': instance.totalSeasons,
  'bestRank': instance.bestRank,
  'bestPosition': instance.bestPosition,
  'totalMatches': instance.totalMatches,
  'totalWins': instance.totalWins,
  'totalLosses': instance.totalLosses,
  'winRate': instance.winRate,
  'bestStreak': instance.bestStreak,
  'highestScore': instance.highestScore,
  'totalXp': instance.totalXp,
  'bestSeason': instance.bestSeason,
  'careerRecords': instance.careerRecords,
  'recentForm': instance.recentForm,
};
