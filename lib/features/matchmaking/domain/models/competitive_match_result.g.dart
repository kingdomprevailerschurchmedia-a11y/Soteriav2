// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_match_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveMatchResult _$CompetitiveMatchResultFromJson(
  Map<String, dynamic> json,
) => _CompetitiveMatchResult(
  matchId: json['matchId'] as String,
  playerId: json['playerId'] as String,
  opponentId: json['opponentId'] as String,
  outcome: $enumDecode(_$MatchOutcomeEnumMap, json['outcome']),
  playerScore: (json['playerScore'] as num).toInt(),
  opponentScore: (json['opponentScore'] as num).toInt(),
  playerPerformance: GameResult.fromJson(
    json['playerPerformance'] as Map<String, dynamic>,
  ),
  opponentPerformance: GameResult.fromJson(
    json['opponentPerformance'] as Map<String, dynamic>,
  ),
  rankChange: json['rankChange'] as Map<String, dynamic>,
  rewards: json['rewards'] as Map<String, dynamic>,
  completedAt: DateTime.parse(json['completedAt'] as String),
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$CompetitiveMatchResultToJson(
  _CompetitiveMatchResult instance,
) => <String, dynamic>{
  'matchId': instance.matchId,
  'playerId': instance.playerId,
  'opponentId': instance.opponentId,
  'outcome': _$MatchOutcomeEnumMap[instance.outcome]!,
  'playerScore': instance.playerScore,
  'opponentScore': instance.opponentScore,
  'playerPerformance': instance.playerPerformance,
  'opponentPerformance': instance.opponentPerformance,
  'rankChange': instance.rankChange,
  'rewards': instance.rewards,
  'completedAt': instance.completedAt.toIso8601String(),
  'schemaVersion': instance.schemaVersion,
};

const _$MatchOutcomeEnumMap = {
  MatchOutcome.victory: 'victory',
  MatchOutcome.defeat: 'defeat',
  MatchOutcome.draw: 'draw',
  MatchOutcome.abandoned: 'abandoned',
  MatchOutcome.cancelled: 'cancelled',
};
