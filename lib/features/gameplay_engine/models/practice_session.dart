import 'package:flutter/foundation.dart';
import 'practice_session_config.dart';

@immutable
class PracticeSession {
  final String sessionId;
  final String uid;
  final PracticeSessionConfig config;
  final DateTime startTime;
  final String status; // initialized, active, completed, abandoned

  const PracticeSession({
    required this.sessionId,
    required this.uid,
    required this.config,
    required this.startTime,
    this.status = 'initialized',
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'uid': uid,
    'config': {
      'categoryId': config.category?.id,
      'difficulty': config.difficulty.name,
      'questionCount': config.questionCount,
      'timerEnabled': config.timerEnabled,
      'type': config.practiceType,
    },
    'startTime': startTime.toIso8601String(),
    'status': status,
  };
}
