import '../../question_content/domain/entities/question.dart';

/// Representation of a question and the player's performance on it for review.
class AnswerReview {
  final Question question;
  final List<String> selectedOptionIds;
  final bool isCorrect;
  final Duration responseTime;

  const AnswerReview({
    required this.question,
    required this.selectedOptionIds,
    required this.isCorrect,
    required this.responseTime,
  });

  bool get isSkipped => selectedOptionIds.isEmpty;
}
