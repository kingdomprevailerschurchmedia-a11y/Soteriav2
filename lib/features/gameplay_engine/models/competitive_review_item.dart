import 'package:flutter/foundation.dart';

@immutable
class CompetitiveReviewItem {
  final String questionId;
  final String questionText;
  final String selectedAnswer;
  final String correctAnswer;
  final String explanation;
  final String? reference;
  final String difficulty;
  final Duration timeTaken;
  final bool isCorrect;

  const CompetitiveReviewItem({
    required this.questionId,
    required this.questionText,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.explanation,
    this.reference,
    required this.difficulty,
    required this.timeTaken,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() => {
    'questionId': questionId,
    'questionText': questionText,
    'selectedAnswer': selectedAnswer,
    'correctAnswer': correctAnswer,
    'explanation': explanation,
    'reference': reference,
    'difficulty': difficulty,
    'timeTaken': timeTaken.inMilliseconds,
    'isCorrect': isCorrect,
  };
}
