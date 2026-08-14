import 'package:flutter/foundation.dart';

enum NotificationType {
  dailyReminder,
  practiceReminder,
  tournamentInvitation,
  tournamentStart,
  tournamentResults,
  friendRequest,
  challengeReceived,
  challengeAccepted,
  challengeDeclined,
  challengeExpiring,
  challengeCancelled,
  challengeCompleted,
  challengeMatchReady,
  rivalryMilestone,
  achievementEarned,
  levelUp,
  streakReminder,
  announcement,
  systemUpdate,
  maintenance,
  promotion,
  rankDemoted,
  rankChanged,
  leaderboardChanged,
  personalBest,
  seasonEnding,
  seasonCompleted,
  seasonResult,
  rewardReceived,
  milestoneReached,
  missionCompleted,
  missionExpiring,
  seasonStarted,
  liveEventStarted,
  liveEventEnding,
  rematchRequest,
  systemAnnouncement;

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationType.announcement,
    );
  }
}

@immutable
class AppNotification {
  final String id;
  final String? userId;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime createdAt;
  final bool read;
  final String? action;
  final Map<String, dynamic> payload;
  final int priority;
  final String? imageUrl;

  const AppNotification({
    required this.id,
    this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    this.read = false,
    this.action,
    this.payload = const {},
    this.priority = 0,
    this.imageUrl,
  });

  AppNotification copyWith({bool? read, String? userId}) {
    return AppNotification(
      id: id,
      userId: userId ?? this.userId,
      title: title,
      body: body,
      type: type,
      createdAt: createdAt,
      read: read ?? this.read,
      action: action,
      payload: payload,
      priority: priority,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body,
    'type': type.name,
    'createdAt': createdAt.toIso8601String(),
    'read': read,
    'action': action,
    'payload': payload,
    'priority': priority,
    'imageUrl': imageUrl,
  };

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body'],
        type: NotificationType.fromString(json['type']),
        createdAt: DateTime.parse(json['createdAt']),
        read: json['read'] ?? false,
        action: json['action'],
        payload: json['payload'] ?? {},
        priority: json['priority'] ?? 0,
        imageUrl: json['imageUrl'],
      );
}
