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

  Map<String, dynamic> toJson() => {
    'id': id,
    'version': version,
    'text': text,
    'explanation': explanation,
    'difficulty': difficulty.name,
    'category': category,
    'subcategory': subcategory,
    'topic': topic,
    'type': type.name,
    'options': options.map((e) => e.toJson()).toList(),
    'correctAnswers': correctAnswers,
    'tags': tags,
    'language': language,
    'estimatedTime': estimatedTime.inSeconds,
    'xpValue': xpValue,
    'status': status.name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'author': author,
    'source': source,
    'schemaVersion': schemaVersion,
    'contentHash': contentHash,
  };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json['id'],
    version: json['version'],
    text: json['text'],
    explanation: json['explanation'],
    difficulty: QuestionDifficulty.values.byName(json['difficulty']),
    category: json['category'],
    subcategory: json['subcategory'],
    topic: json['topic'],
    type: QuestionType.values.byName(json['type']),
    options: (json['options'] as List).map((e) => Answer.fromJson(e)).toList(),
    correctAnswers: List<String>.from(json['correctAnswers']),
    tags: List<String>.from(json['tags']),
    language: json['language'],
    estimatedTime: Duration(seconds: json['estimatedTime']),
    xpValue: json['xpValue'],
    status: QuestionStatus.values.byName(json['status']),
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    author: json['author'],
    source: json['source'],
    schemaVersion: json['schemaVersion'],
    contentHash: json['contentHash'],
  );

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

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'mediaUrl': mediaUrl,
  };

  factory Answer.fromJson(Map<String, dynamic> json) =>
      Answer(id: json['id'], text: json['text'], mediaUrl: json['mediaUrl']);
}
