import 'package:uuid/uuid.dart';

/// Represents the different types of questions supported by the engine.
enum QuestionType {
  multipleChoice,
  trueFalse,
  image,
  audio,
  video,
  fillInBlank,
  ordering,
  matching,
  code,
  mathematics,
  aiGenerated,
}

/// Represents the difficulty levels for a question.
enum QuestionDifficulty { easy, medium, hard, expert, adaptive }

/// Represents the lifecycle status of a question in the content bank.
enum QuestionStatus { draft, review, published, archived, deprecated }

/// Domain entity representing a single question and its associated metadata.
class Question {
  final String id;
  final String version;
  final String text;
  final String? explanation;
  final QuestionDifficulty difficulty;
  final String category;
  final String? subcategory;
  final String? topic;
  final QuestionType type;
  final List<Answer> options;
  final List<String> correctAnswers; // IDs of the correct answers
  final List<String> tags;
  final String language;
  final Duration estimatedTime;
  final int xpValue;
  final QuestionStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? author;
  final String source;
  final int schemaVersion;
  final String contentHash; // For integrity validation

  Question({
    String? id,
    required this.version,
    required this.text,
    this.explanation,
    required this.difficulty,
    required this.category,
    this.subcategory,
    this.topic,
    required this.type,
    required this.options,
    required this.correctAnswers,
    this.tags = const [],
    this.language = 'en',
    this.estimatedTime = const Duration(seconds: 30),
    this.xpValue = 10,
    this.status = QuestionStatus.published,
    required this.createdAt,
    required this.updatedAt,
    this.author,
    required this.source,
    required this.schemaVersion,
    required this.contentHash,
  }) : id = id ?? const Uuid().v4();

  /// Logic to check if a provided answer is correct.
  bool isAnswerCorrect(String answerId) => correctAnswers.contains(answerId);

  /// Logic to check if multiple answers provided are all correct (for multi-select).
  bool areAnswersCorrect(List<String> answerIds) {
    if (answerIds.length != correctAnswers.length) return false;
    return answerIds.every((id) => correctAnswers.contains(id));
  }
}

/// Domain entity representing a potential answer to a question.
class Answer {
  final String id;
  final String text;
  final String? mediaUrl; // For image/audio options

  const Answer({required this.id, required this.text, this.mediaUrl});
}
