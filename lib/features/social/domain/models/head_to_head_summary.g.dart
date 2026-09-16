// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'head_to_head_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeadToHeadSummary _$HeadToHeadSummaryFromJson(Map<String, dynamic> json) =>
    _HeadToHeadSummary(
      playerAId: json['playerAId'] as String,
      playerBId: json['playerBId'] as String,
      totalMatches: (json['totalMatches'] as num).toInt(),
      playerAWins: (json['playerAWins'] as num).toInt(),
      playerBWins: (json['playerBWins'] as num).toInt(),
      draws: (json['draws'] as num).toInt(),
      playerAWinRate: (json['playerAWinRate'] as num).toDouble(),
      playerBWinRate: (json['playerBWinRate'] as num).toDouble(),
      recentResults:
          (json['recentResults'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$CompetitiveOutcomeEnumMap, e))
              .toList() ??
          const [],
      playerACurrentStreak: (json['playerACurrentStreak'] as num).toInt(),
      playerBCurrentStreak: (json['playerBCurrentStreak'] as num).toInt(),
      playerABestStreak: (json['playerABestStreak'] as num).toInt(),
      playerBBestStreak: (json['playerBBestStreak'] as num).toInt(),
      lastMatchAt: json['lastMatchAt'] == null
          ? null
          : DateTime.parse(json['lastMatchAt'] as String),
    );

Map<String, dynamic> _$HeadToHeadSummaryToJson(_HeadToHeadSummary instance) =>
    <String, dynamic>{
      'playerAId': instance.playerAId,
      'playerBId': instance.playerBId,
      'totalMatches': instance.totalMatches,
      'playerAWins': instance.playerAWins,
      'playerBWins': instance.playerBWins,
      'draws': instance.draws,
      'playerAWinRate': instance.playerAWinRate,
      'playerBWinRate': instance.playerBWinRate,
      'recentResults': instance.recentResults
          .map((e) => _$CompetitiveOutcomeEnumMap[e]!)
          .toList(),
      'playerACurrentStreak': instance.playerACurrentStreak,
      'playerBCurrentStreak': instance.playerBCurrentStreak,
      'playerABestStreak': instance.playerABestStreak,
      'playerBBestStreak': instance.playerBBestStreak,
      'lastMatchAt': instance.lastMatchAt?.toIso8601String(),
    };

const _$CompetitiveOutcomeEnumMap = {
  CompetitiveOutcome.win: 'win',
  CompetitiveOutcome.loss: 'loss',
  CompetitiveOutcome.draw: 'draw',
  CompetitiveOutcome.placement: 'placement',
};
