import 'package:flutter/foundation.dart';

enum CompetitiveEventType {
  rankPromoted,
  rankDemoted,
  rankReached,
  rankChanged,
  leaderboardChanged,
  leaderboardMilestone,
  personalBest,
  seasonEnding,
  seasonStarted,
  seasonCompleted,
  seasonResult,
  seasonResultAvailable,
  rewardReceived,
  milestoneCompleted,
  missionCompleted,
  achievementUnlocked,
  newSeasonStarted,
  gameMilestone,
  winMilestone,
  careerMilestone,
  badgeEarned,
  titleEarned,
  tournamentResult,
  matchCompleted,
  streakReached,
  challengeAccepted,
  challengeCompleted,
  rivalryMilestone,
  liveEventStarted,
  liveEventEnding,
  systemAnnouncement,
  rematchRequest,
}

@immutable
class CompetitiveEvent {
  final String eventId;
  final String userId;
  final CompetitiveEventType type;
  final String title;
  final String body;
  final Map<String, dynamic> metadata;
  final String? seasonId;
  final DateTime createdAt;
  final int priority;
  final String? deduplicationKey;

  const CompetitiveEvent({
    required this.eventId,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.metadata = const {},
    this.seasonId,
    required this.createdAt,
    this.priority = 1,
    this.deduplicationKey,
  });

  factory CompetitiveEvent.fromJson(Map<String, dynamic> json) {
    return CompetitiveEvent(
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      type: CompetitiveEventType.values.byName(json['type'] as String),
      title: json['title'] as String,
      body: json['body'] as String,
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
      seasonId: json['seasonId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      priority: (json['priority'] as num?)?.toInt() ?? 1,
      deduplicationKey: json['deduplicationKey'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'userId': userId,
      'type': type.name,
      'title': title,
      'body': body,
      'metadata': metadata,
      'seasonId': seasonId,
      'createdAt': createdAt.toIso8601String(),
      'priority': priority,
      'deduplicationKey': deduplicationKey,
    };
  }
}
