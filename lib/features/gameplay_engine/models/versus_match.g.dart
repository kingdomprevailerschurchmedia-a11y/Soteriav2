// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versus_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VersusMatch _$VersusMatchFromJson(Map<String, dynamic> json) => _VersusMatch(
  matchId: json['matchId'] as String,
  playerAId: json['playerAId'] as String,
  playerBId: json['playerBId'] as String,
  status: $enumDecode(_$MatchStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  startedAt: json['startedAt'] == null
      ? null
      : DateTime.parse(json['startedAt'] as String),
  endedAt: json['endedAt'] == null
      ? null
      : DateTime.parse(json['endedAt'] as String),
  playerASessionId: json['playerASessionId'] as String?,
  playerBSessionId: json['playerBSessionId'] as String?,
  playerAReady: json['playerAReady'] as bool? ?? false,
  playerBReady: json['playerBReady'] as bool? ?? false,
  playerAScore: (json['playerAScore'] as num?)?.toInt() ?? 0,
  playerBScore: (json['playerBScore'] as num?)?.toInt() ?? 0,
  playerAProgress: (json['playerAProgress'] as num?)?.toInt() ?? 0,
  playerBProgress: (json['playerBProgress'] as num?)?.toInt() ?? 0,
  mode: $enumDecodeNullable(_$GameModeEnumMap, json['mode']) ?? GameMode.versus,
  configuration: json['configuration'] as Map<String, dynamic>? ?? const {},
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$VersusMatchToJson(_VersusMatch instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'playerAId': instance.playerAId,
      'playerBId': instance.playerBId,
      'status': _$MatchStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'playerASessionId': instance.playerASessionId,
      'playerBSessionId': instance.playerBSessionId,
      'playerAReady': instance.playerAReady,
      'playerBReady': instance.playerBReady,
      'playerAScore': instance.playerAScore,
      'playerBScore': instance.playerBScore,
      'playerAProgress': instance.playerAProgress,
      'playerBProgress': instance.playerBProgress,
      'mode': _$GameModeEnumMap[instance.mode]!,
      'configuration': instance.configuration,
      'schemaVersion': instance.schemaVersion,
    };

const _$MatchStatusEnumMap = {
  MatchStatus.created: 'created',
  MatchStatus.waiting: 'waiting',
  MatchStatus.ready: 'ready',
  MatchStatus.countdown: 'countdown',
  MatchStatus.active: 'active',
  MatchStatus.finishing: 'finishing',
  MatchStatus.processing: 'processing',
  MatchStatus.completed: 'completed',
  MatchStatus.cancelled: 'cancelled',
  MatchStatus.abandoned: 'abandoned',
  MatchStatus.failed: 'failed',
  MatchStatus.expired: 'expired',
};

const _$GameModeEnumMap = {
  GameMode.practice: 'practice',
  GameMode.pro: 'pro',
  GameMode.versus: 'versus',
  GameMode.tournament: 'tournament',
  GameMode.challenge: 'challenge',
  GameMode.dailyQuiz: 'dailyQuiz',
  GameMode.event: 'event',
};
