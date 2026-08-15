import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';

/// The final, immutable output of a decision made by the Answer Engine.
class AnswerResult {
  final String submissionId;
  final String questionId;
  final AnswerDecision decision;
  final List<String> selectedOptionIds;
  final List<String> correctOptionIds;
  final int xpEarned;
  final DateTime timestamp;
  final Duration responseTime;
  final String? questionVersion;
  final Map<String, dynamic> metadata;

  const AnswerResult({
    required this.submissionId,
    required this.questionId,
    required this.decision,
    this.selectedOptionIds = const [],
    required this.correctOptionIds,
    this.xpEarned = 0,
    required this.timestamp,
    this.responseTime = Duration.zero,
    this.questionVersion,
    this.metadata = const {},
  });

  bool get isCorrect => decision == AnswerDecision.correct;
  bool get isWrong => decision == AnswerDecision.wrong;
  bool get isTimedOut => decision == AnswerDecision.timeout;
  bool get isSkipped => decision == AnswerDecision.skipped;

  Map<String, dynamic> toJson() => {
    'submissionId': submissionId,
    'questionId': questionId,
    'decision': decision.name,
    'selectedOptionIds': selectedOptionIds,
    'correctOptionIds': correctOptionIds,
    'xpEarned': xpEarned,
    'timestamp': timestamp.toIso8601String(),
    'responseTime': responseTime.inMilliseconds,
    'questionVersion': questionVersion,
    'metadata': metadata,
  };

  factory AnswerResult.fromJson(Map<String, dynamic> json) => AnswerResult(
    submissionId: json['submissionId'],
    questionId: json['questionId'],
    decision: AnswerDecision.values.byName(json['decision']),
    selectedOptionIds: List<String>.from(json['selectedOptionIds'] ?? []),
    correctOptionIds: List<String>.from(json['correctOptionIds']),
    xpEarned: json['xpEarned'] ?? 0,
    timestamp: DateTime.parse(json['timestamp']),
    responseTime: Duration(milliseconds: json['responseTime'] ?? 0),
    questionVersion: json['questionVersion'],
    metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
  );
}
