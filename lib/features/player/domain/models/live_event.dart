import 'package:flutter/foundation.dart';

enum LiveEventStatus {
  upcoming,
  live,
  ending,
  ended,
  cancelled,
  locked,
}

@immutable
class LiveEvent {
  final String eventId;
  final String title;
  final String description;
  final LiveEventStatus status;
  final DateTime startAt;
  final DateTime endAt;
  final String category;
  final List<String> rules;
  final Map<String, dynamic> entryRequirements;
  final Map<String, dynamic> rewardConfiguration;
  final Map<String, dynamic> leaderboardConfiguration;
  final int participantCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? imageUrl;
  final String? icon;
  final Map<String, dynamic> metadata;

  const LiveEvent({
    required this.eventId,
    required this.title,
    required this.description,
    required this.status,
    required this.startAt,
    required this.endAt,
    required this.category,
    required this.rules,
    this.entryRequirements = const {},
    this.rewardConfiguration = const {},
    this.leaderboardConfiguration = const {},
    this.participantCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
    this.icon,
    this.metadata = const {},
  });

  LiveEvent copyWith({
    String? eventId,
    String? title,
    String? description,
    LiveEventStatus? status,
    DateTime? startAt,
    DateTime? endAt,
    String? category,
    List<String>? rules,
    Map<String, dynamic>? entryRequirements,
    Map<String, dynamic>? rewardConfiguration,
    Map<String, dynamic>? leaderboardConfiguration,
    int? participantCount,
    DateTime? updatedAt,
    String? imageUrl,
    String? icon,
    Map<String, dynamic>? metadata,
  }) {
    return LiveEvent(
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      category: category ?? this.category,
      rules: rules ?? this.rules,
      entryRequirements: entryRequirements ?? this.entryRequirements,
      rewardConfiguration: rewardConfiguration ?? this.rewardConfiguration,
      leaderboardConfiguration: leaderboardConfiguration ?? this.leaderboardConfiguration,
      participantCount: participantCount ?? this.participantCount,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      icon: icon ?? this.icon,
      metadata: metadata ?? this.metadata,
    );
  }

  factory LiveEvent.fromJson(Map<String, dynamic> json) {
    return LiveEvent(
      eventId: json['eventId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: LiveEventStatus.values.byName(json['status'] as String),
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      category: json['category'] as String,
      rules: List<String>.from(json['rules'] ?? []),
      entryRequirements: Map<String, dynamic>.from(json['entryRequirements'] ?? {}),
      rewardConfiguration: Map<String, dynamic>.from(json['rewardConfiguration'] ?? {}),
      leaderboardConfiguration: Map<String, dynamic>.from(json['leaderboardConfiguration'] ?? {}),
      participantCount: (json['participantCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      icon: json['icon'] as String?,
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'title': title,
      'description': description,
      'status': status.name,
      'startAt': startAt.toIso8601String(),
      'endAt': endAt.toIso8601String(),
      'category': category,
      'rules': rules,
      'entryRequirements': entryRequirements,
      'rewardConfiguration': rewardConfiguration,
      'leaderboardConfiguration': leaderboardConfiguration,
      'participantCount': participantCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'icon': icon,
      'metadata': metadata,
    };
  }
}

extension LiveEventX on LiveEvent {
  LiveEventStatus calculateStatus(DateTime now) {
    if (status == LiveEventStatus.cancelled) return status;
    if (now.isBefore(startAt)) return LiveEventStatus.upcoming;
    if (now.isAfter(endAt)) return LiveEventStatus.ended;
    if (endAt.difference(now) < const Duration(hours: 4)) {
      return LiveEventStatus.ending;
    }
    return LiveEventStatus.live;
  }
}
