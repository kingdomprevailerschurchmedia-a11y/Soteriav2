// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_progression.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerProgression _$PlayerProgressionFromJson(
  Map<String, dynamic> json,
) => _PlayerProgression(
  userId: json['userId'] as String,
  currentLevel: (json['currentLevel'] as num).toInt(),
  currentXp: (json['currentXp'] as num).toInt(),
  lifetimeXp: (json['lifetimeXp'] as num).toInt(),
  xpRequiredForCurrentLevel: (json['xpRequiredForCurrentLevel'] as num).toInt(),
  xpRequiredForNextLevel: (json['xpRequiredForNextLevel'] as num).toInt(),
  xpProgress: (json['xpProgress'] as num).toDouble(),
  currentRank: json['currentRank'] as String,
  currentRankTier: json['currentRankTier'] as String,
  rankPoints: (json['rankPoints'] as num).toInt(),
  rankProgress: (json['rankProgress'] as num).toDouble(),
  seasonId: json['seasonId'] as String,
  seasonXp: (json['seasonXp'] as num).toInt(),
  seasonRankPoints: (json['seasonRankPoints'] as num).toInt(),
  lastUpdated: const RequiredTimestampConverter().fromJson(json['lastUpdated']),
  dailyStreak: (json['dailyStreak'] as num?)?.toInt() ?? 0,
  longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
  maxQuestionStreak: (json['maxQuestionStreak'] as num?)?.toInt() ?? 0,
  lastEngagementDate: const EngagementDateConverter().fromJson(
    json['lastEngagementDate'],
  ),
  lastXpTransactionId: json['lastXpTransactionId'] as String?,
  lastRankTransactionId: json['lastRankTransactionId'] as String?,
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$PlayerProgressionToJson(_PlayerProgression instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'currentLevel': instance.currentLevel,
      'currentXp': instance.currentXp,
      'lifetimeXp': instance.lifetimeXp,
      'xpRequiredForCurrentLevel': instance.xpRequiredForCurrentLevel,
      'xpRequiredForNextLevel': instance.xpRequiredForNextLevel,
      'xpProgress': instance.xpProgress,
      'currentRank': instance.currentRank,
      'currentRankTier': instance.currentRankTier,
      'rankPoints': instance.rankPoints,
      'rankProgress': instance.rankProgress,
      'seasonId': instance.seasonId,
      'seasonXp': instance.seasonXp,
      'seasonRankPoints': instance.seasonRankPoints,
      'lastUpdated': const RequiredTimestampConverter().toJson(
        instance.lastUpdated,
      ),
      'dailyStreak': instance.dailyStreak,
      'longestStreak': instance.longestStreak,
      'maxQuestionStreak': instance.maxQuestionStreak,
      'lastEngagementDate': const EngagementDateConverter().toJson(
        instance.lastEngagementDate,
      ),
      'lastXpTransactionId': instance.lastXpTransactionId,
      'lastRankTransactionId': instance.lastRankTransactionId,
      'schemaVersion': instance.schemaVersion,
    };
