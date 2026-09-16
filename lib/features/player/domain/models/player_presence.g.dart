// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_presence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerPresence _$PlayerPresenceFromJson(Map<String, dynamic> json) =>
    _PlayerPresence(
      userId: json['userId'] as String,
      status: $enumDecode(_$PresenceStatusEnumMap, json['status']),
      lastSeenAt: DateTime.parse(json['lastSeenAt'] as String),
      lastHeartbeatAt: DateTime.parse(json['lastHeartbeatAt'] as String),
      showOnlineStatus: json['showOnlineStatus'] as bool? ?? true,
      showActivity: json['showActivity'] as bool? ?? true,
      showMatchStatus: json['showMatchStatus'] as bool? ?? true,
      currentMatchId: json['currentMatchId'] as String?,
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$PlayerPresenceToJson(_PlayerPresence instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'status': _$PresenceStatusEnumMap[instance.status]!,
      'lastSeenAt': instance.lastSeenAt.toIso8601String(),
      'lastHeartbeatAt': instance.lastHeartbeatAt.toIso8601String(),
      'showOnlineStatus': instance.showOnlineStatus,
      'showActivity': instance.showActivity,
      'showMatchStatus': instance.showMatchStatus,
      'currentMatchId': instance.currentMatchId,
      'schemaVersion': instance.schemaVersion,
    };

const _$PresenceStatusEnumMap = {
  PresenceStatus.online: 'online',
  PresenceStatus.recentlyActive: 'recentlyActive',
  PresenceStatus.offline: 'offline',
  PresenceStatus.inMatch: 'inMatch',
  PresenceStatus.unavailable: 'unavailable',
  PresenceStatus.hidden: 'hidden',
};
