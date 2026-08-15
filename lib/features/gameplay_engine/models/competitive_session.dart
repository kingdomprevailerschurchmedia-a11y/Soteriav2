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
  final String status;
  final int reservedFee;

  const CompetitiveSession({
    required this.sessionId,
    required this.uid,
    required this.config,
    required this.questions,
    required this.startTime,
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
    'questions': questions.map((q) => q.toJson()).toList(),
    'startTime': startTime.toIso8601String(),
    'status': status,
    'reservedFee': reservedFee,
  };
}
