import 'package:flutter/foundation.dart';

enum ParticipationStatus {
  eligible,
  joined,
  inProgress,
  completed,
  disqualified,
  expired,
}

@immutable
class EventParticipation {
  final String eventId;
  final String userId;
  final ParticipationStatus status;
  final int score;
  final int? rank;
  final DateTime? joinedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;

  const EventParticipation({
    required this.eventId,
    required this.userId,
    required this.status,
    this.score = 0,
    this.rank,
    this.joinedAt,
    this.startedAt,
    this.completedAt,
  });

  EventParticipation copyWith({
    ParticipationStatus? status,
    int? score,
    int? rank,
    DateTime? joinedAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) {
    return EventParticipation(
      eventId: eventId,
      userId: userId,
      status: status ?? this.status,
      score: score ?? this.score,
      rank: rank ?? this.rank,
      joinedAt: joinedAt ?? this.joinedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory EventParticipation.fromJson(Map<String, dynamic> json) {
    return EventParticipation(
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      status: ParticipationStatus.values.byName(json['status'] as String),
      score: (json['score'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt(),
      joinedAt: json['joinedAt'] != null ? DateTime.parse(json['joinedAt'] as String) : null,
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt'] as String) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'userId': userId,
      'status': status.name,
      'score': score,
      'rank': rank,
      'joinedAt': joinedAt?.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}
