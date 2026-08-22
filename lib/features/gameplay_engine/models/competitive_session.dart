import 'package:flutter/foundation.dart';
import '../../question_content/domain/entities/question.dart';
import 'pro_session_config.dart';

@immutable
class CompetitiveSession {
  final String sessionId;
  final String uid;
  final ProSessionConfig config;
  final List<Question> questions;
  final DateTime startTime;
  final DateTime createdAt;
  final DateTime? lastHeartbeatAt;
  final String status;
  final int reservedFee;

  const CompetitiveSession({
    required this.sessionId,
    required this.uid,
    required this.config,
    required this.questions,
    required this.startTime,
    required this.createdAt,
    this.lastHeartbeatAt,
    this.status = 'initialized',
    required this.reservedFee,
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'uid': uid,
    'config': {
      'categoryId': config.category?.id,
      'difficulty': config.difficulty.name,
      'questionCount': config.questionCount,
      'entryFee': config.entryFee,
      'timerEnabled': config.timerEnabled,
    },
    'questions': questions.map((q) {
      final json = q.toJson();
      // Hardening: Ensure nested options are serialized to prevent Firestore "Invalid argument" errors
      json['options'] = q.options.map((a) => a.toJson()).toList();
      return json;
    }).toList(),
    'startTime': startTime.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'lastHeartbeatAt': lastHeartbeatAt?.toIso8601String(),
    'updatedAt': lastHeartbeatAt?.toIso8601String() ?? startTime.toIso8601String(),
    'status': status,
    'reservedFee': reservedFee,
  };
}
