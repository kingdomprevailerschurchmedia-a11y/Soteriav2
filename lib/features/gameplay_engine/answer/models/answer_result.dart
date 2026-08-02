import 'package:soteria/features/gameplay_engine/answer/models/answer_decision.dart';

/// The final, immutable output of a decision made by the Answer Engine.
class AnswerResult {
  final String submissionId;
  final String questionId;
  final AnswerDecision decision;
  final List<String> correctOptionIds;
  final int xpEarned;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;

  const AnswerResult({
    required this.submissionId,
    required this.questionId,
    required this.decision,
    required this.correctOptionIds,
    this.xpEarned = 0,
    required this.timestamp,
    this.metadata = const {},
  });

  bool get isCorrect => decision == AnswerDecision.correct;
  bool get isWrong => decision == AnswerDecision.wrong;
}
