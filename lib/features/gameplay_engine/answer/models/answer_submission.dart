import 'package:uuid/uuid.dart';

/// Immutable record of a user's attempt to answer a question.
class AnswerSubmission {
  final String submissionId;
  final String questionId;
  final List<String> selectedOptionIds;
  final DateTime timestamp;
  final Duration responseTime;

  AnswerSubmission({
    String? submissionId,
    required this.questionId,
    required this.selectedOptionIds,
    required this.timestamp,
    required this.responseTime,
  }) : submissionId = submissionId ?? const Uuid().v4();
}
