import 'package:flutter/foundation.dart';

enum LiveEventStatus { upcoming, active, ending, completed, cancelled }

@immutable
class LiveEvent {
  final String eventId;
  final String name;
  final String description;
  final LiveEventStatus status;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime createdAt;
  final String? imageUrl;
  final String? icon;
  final List<String> rules;
  final Map<String, dynamic> rewardConfig;
  final Map<String, dynamic> eligibility;
  final Map<String, dynamic> metadata;

  const LiveEvent({
    required this.eventId,
    required this.name,
    required this.description,
    required this.status,
    required this.startAt,
    required this.endAt,
    required this.createdAt,
    this.imageUrl,
    this.icon,
    this.rules = const [],
    this.rewardConfig = const {},
    this.eligibility = const {},
    this.metadata = const {},
  });

  factory LiveEvent.fromJson(Map<String, dynamic> json) {
    return LiveEvent(
      eventId: json['eventId'],
      name: json['name'],
      description: json['description'],
      status: LiveEventStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => LiveEventStatus.upcoming,
      ),
      startAt: DateTime.parse(json['startAt']),
      endAt: DateTime.parse(json['endAt']),
      createdAt: DateTime.parse(json['createdAt']),
      imageUrl: json['imageUrl'],
      icon: json['icon'],
      rules: List<String>.from(json['rules'] ?? []),
      rewardConfig: Map<String, dynamic>.from(json['rewardConfig'] ?? {}),
      eligibility: Map<String, dynamic>.from(json['eligibility'] ?? {}),
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'name': name,
        'description': description,
        'status': status.name,
        'startAt': startAt.toIso8601String(),
        'endAt': endAt.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'imageUrl': imageUrl,
        'icon': icon,
        'rules': rules,
        'rewardConfig': rewardConfig,
        'eligibility': eligibility,
        'metadata': metadata,
      };
}

extension LiveEventX on LiveEvent {
  LiveEventStatus calculateStatus(DateTime now) {
    if (status == LiveEventStatus.cancelled) return status;
    if (now.isBefore(startAt)) return LiveEventStatus.upcoming;
    if (now.isAfter(endAt)) return LiveEventStatus.completed;
    if (endAt.difference(now) < const Duration(hours: 4)) {
      return LiveEventStatus.ending;
    }
    return LiveEventStatus.active;
  }
}
