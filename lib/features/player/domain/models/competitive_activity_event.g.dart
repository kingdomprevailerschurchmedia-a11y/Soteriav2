// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_activity_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveActivityEvent _$CompetitiveActivityEventFromJson(
  Map<String, dynamic> json,
) => _CompetitiveActivityEvent(
  id: json['id'] as String,
  userId: json['userId'] as String,
  type: $enumDecode(_$CompetitiveEventTypeEnumMap, json['type']),
  title: json['title'] as String,
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  seasonId: json['seasonId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  deepLink: json['deepLink'] as String?,
  importance:
      $enumDecodeNullable(_$ActivityImportanceEnumMap, json['importance']) ??
      ActivityImportance.normal,
  icon: json['icon'] as String?,
  visibility:
      $enumDecodeNullable(_$ActivityVisibilityEnumMap, json['visibility']) ??
      ActivityVisibility.public,
);

Map<String, dynamic> _$CompetitiveActivityEventToJson(
  _CompetitiveActivityEvent instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'type': _$CompetitiveEventTypeEnumMap[instance.type]!,
  'title': instance.title,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
  'seasonId': instance.seasonId,
  'metadata': instance.metadata,
  'deepLink': instance.deepLink,
  'importance': _$ActivityImportanceEnumMap[instance.importance]!,
  'icon': instance.icon,
  'visibility': _$ActivityVisibilityEnumMap[instance.visibility]!,
};

const _$CompetitiveEventTypeEnumMap = {
  CompetitiveEventType.rankPromoted: 'rankPromoted',
  CompetitiveEventType.rankDemoted: 'rankDemoted',
  CompetitiveEventType.rankReached: 'rankReached',
  CompetitiveEventType.rankChanged: 'rankChanged',
  CompetitiveEventType.leaderboardChanged: 'leaderboardChanged',
  CompetitiveEventType.leaderboardMilestone: 'leaderboardMilestone',
  CompetitiveEventType.personalBest: 'personalBest',
  CompetitiveEventType.seasonEnding: 'seasonEnding',
  CompetitiveEventType.seasonStarted: 'seasonStarted',
  CompetitiveEventType.seasonCompleted: 'seasonCompleted',
  CompetitiveEventType.seasonResult: 'seasonResult',
  CompetitiveEventType.seasonResultAvailable: 'seasonResultAvailable',
  CompetitiveEventType.rewardReceived: 'rewardReceived',
  CompetitiveEventType.milestoneCompleted: 'milestoneCompleted',
  CompetitiveEventType.missionCompleted: 'missionCompleted',
  CompetitiveEventType.achievementUnlocked: 'achievementUnlocked',
  CompetitiveEventType.newSeasonStarted: 'newSeasonStarted',
  CompetitiveEventType.gameMilestone: 'gameMilestone',
  CompetitiveEventType.winMilestone: 'winMilestone',
  CompetitiveEventType.careerMilestone: 'careerMilestone',
  CompetitiveEventType.badgeEarned: 'badgeEarned',
  CompetitiveEventType.titleEarned: 'titleEarned',
  CompetitiveEventType.tournamentResult: 'tournamentResult',
  CompetitiveEventType.matchCompleted: 'matchCompleted',
  CompetitiveEventType.streakReached: 'streakReached',
  CompetitiveEventType.challengeAccepted: 'challengeAccepted',
  CompetitiveEventType.challengeCompleted: 'challengeCompleted',
  CompetitiveEventType.rivalryMilestone: 'rivalryMilestone',
  CompetitiveEventType.liveEventStarted: 'liveEventStarted',
  CompetitiveEventType.liveEventEnding: 'liveEventEnding',
  CompetitiveEventType.systemAnnouncement: 'systemAnnouncement',
  CompetitiveEventType.rematchRequest: 'rematchRequest',
  CompetitiveEventType.friendshipEstablished: 'friendshipEstablished',
};

const _$ActivityImportanceEnumMap = {
  ActivityImportance.low: 'low',
  ActivityImportance.normal: 'normal',
  ActivityImportance.high: 'high',
  ActivityImportance.milestone: 'milestone',
};

const _$ActivityVisibilityEnumMap = {
  ActivityVisibility.public: 'public',
  ActivityVisibility.friends: 'friends',
  ActivityVisibility.private: 'private',
};
