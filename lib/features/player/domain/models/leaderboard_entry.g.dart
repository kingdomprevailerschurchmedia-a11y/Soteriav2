// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) =>
    _LeaderboardEntry(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      avatarId: json['avatarId'] as String?,
      rankPoints: (json['rankPoints'] as num).toInt(),
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      rankTier: json['rankTier'] as String,
      division: (json['division'] as num).toInt(),
      position: (json['position'] as num).toInt(),
      registrationOrder: (json['registrationOrder'] as num?)?.toInt() ?? 0,
      titleId: json['titleId'] as String?,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$LeaderboardEntryToJson(_LeaderboardEntry instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'avatarId': instance.avatarId,
      'rankPoints': instance.rankPoints,
      'xp': instance.xp,
      'rankTier': instance.rankTier,
      'division': instance.division,
      'position': instance.position,
      'registrationOrder': instance.registrationOrder,
      'titleId': instance.titleId,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'schemaVersion': instance.schemaVersion,
    };
