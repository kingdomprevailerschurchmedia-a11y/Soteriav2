// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchmaking_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchmakingSession _$MatchmakingSessionFromJson(Map<String, dynamic> json) =>
    _MatchmakingSession(
      sessionId: json['sessionId'] as String,
      userId: json['userId'] as String,
      status: $enumDecode(_$MatchmakingStatusEnumMap, json['status']),
      queuedAt: DateTime.parse(json['queuedAt'] as String),
      matchedAt: json['matchedAt'] == null
          ? null
          : DateTime.parse(json['matchedAt'] as String),
      opponentId: json['opponentId'] as String?,
      matchId: json['matchId'] as String?,
      configuration: json['configuration'] as Map<String, dynamic>? ?? const {},
      rankSnapshot: json['rankSnapshot'] as Map<String, dynamic>? ?? const {},
      isReady: json['isReady'] as bool? ?? false,
      opponentReady: json['opponentReady'] as bool? ?? false,
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$MatchmakingSessionToJson(_MatchmakingSession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'status': _$MatchmakingStatusEnumMap[instance.status]!,
      'queuedAt': instance.queuedAt.toIso8601String(),
      'matchedAt': instance.matchedAt?.toIso8601String(),
      'opponentId': instance.opponentId,
      'matchId': instance.matchId,
      'configuration': instance.configuration,
      'rankSnapshot': instance.rankSnapshot,
      'isReady': instance.isReady,
      'opponentReady': instance.opponentReady,
      'schemaVersion': instance.schemaVersion,
    };

const _$MatchmakingStatusEnumMap = {
  MatchmakingStatus.idle: 'idle',
  MatchmakingStatus.queuing: 'queuing',
  MatchmakingStatus.searching: 'searching',
  MatchmakingStatus.matchFound: 'matchFound',
  MatchmakingStatus.confirming: 'confirming',
  MatchmakingStatus.matched: 'matched',
  MatchmakingStatus.cancelled: 'cancelled',
  MatchmakingStatus.expired: 'expired',
  MatchmakingStatus.failed: 'failed',
  MatchmakingStatus.completed: 'completed',
};
