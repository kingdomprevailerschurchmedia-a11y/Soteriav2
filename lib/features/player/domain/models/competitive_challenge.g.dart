// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveChallenge _$CompetitiveChallengeFromJson(
  Map<String, dynamic> json,
) => _CompetitiveChallenge(
  challengeId: json['challengeId'] as String,
  challengerId: json['challengerId'] as String,
  challengedPlayerId: json['challengedPlayerId'] as String,
  type: $enumDecode(_$ChallengeTypeEnumMap, json['type']),
  target: (json['target'] as num).toDouble(),
  status: $enumDecode(_$ChallengeStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  startAt: json['startAt'] == null
      ? null
      : DateTime.parse(json['startAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  challengerProgress: (json['challengerProgress'] as num?)?.toDouble() ?? 0.0,
  opponentProgress: (json['opponentProgress'] as num?)?.toDouble() ?? 0.0,
  seasonId: json['seasonId'] as String?,
  rewardType: $enumDecodeNullable(_$RewardTypeEnumMap, json['rewardType']),
  rewardAmount: (json['rewardAmount'] as num?)?.toInt(),
  mode: $enumDecodeNullable(_$GameModeEnumMap, json['mode']) ?? GameMode.versus,
  configuration: json['configuration'] as Map<String, dynamic>? ?? const {},
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$CompetitiveChallengeToJson(
  _CompetitiveChallenge instance,
) => <String, dynamic>{
  'challengeId': instance.challengeId,
  'challengerId': instance.challengerId,
  'challengedPlayerId': instance.challengedPlayerId,
  'type': _$ChallengeTypeEnumMap[instance.type]!,
  'target': instance.target,
  'status': _$ChallengeStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'expiresAt': instance.expiresAt.toIso8601String(),
  'startAt': instance.startAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'challengerProgress': instance.challengerProgress,
  'opponentProgress': instance.opponentProgress,
  'seasonId': instance.seasonId,
  'rewardType': _$RewardTypeEnumMap[instance.rewardType],
  'rewardAmount': instance.rewardAmount,
  'mode': _$GameModeEnumMap[instance.mode]!,
  'configuration': instance.configuration,
  'schemaVersion': instance.schemaVersion,
};

const _$ChallengeTypeEnumMap = {
  ChallengeType.matchWins: 'matchWins',
  ChallengeType.matchScore: 'matchScore',
  ChallengeType.winStreak: 'winStreak',
  ChallengeType.totalPoints: 'totalPoints',
  ChallengeType.accuracy: 'accuracy',
  ChallengeType.categoryPerformance: 'categoryPerformance',
  ChallengeType.headToHeadWins: 'headToHeadWins',
};

const _$ChallengeStatusEnumMap = {
  ChallengeStatus.pending: 'pending',
  ChallengeStatus.accepted: 'accepted',
  ChallengeStatus.declined: 'declined',
  ChallengeStatus.expired: 'expired',
  ChallengeStatus.cancelled: 'cancelled',
  ChallengeStatus.active: 'active',
  ChallengeStatus.completed: 'completed',
  ChallengeStatus.invalid: 'invalid',
};

const _$RewardTypeEnumMap = {
  RewardType.xp: 'xp',
  RewardType.coins: 'coins',
  RewardType.tokens: 'tokens',
  RewardType.badge: 'badge',
  RewardType.achievement: 'achievement',
  RewardType.cosmetic: 'cosmetic',
  RewardType.title: 'title',
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
