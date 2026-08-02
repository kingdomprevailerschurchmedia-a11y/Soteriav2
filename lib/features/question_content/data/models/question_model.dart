import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

/// Data model for Question that includes JSON serialization logic.
class QuestionModel extends Question {
  QuestionModel({
    super.id,
    required super.version,
    required super.text,
    super.explanation,
    required super.difficulty,
    required super.category,
    super.subcategory,
    super.topic,
    required super.type,
    required super.options,
    required super.correctAnswers,
    super.tags,
    super.language,
    super.estimatedTime,
    super.xpValue,
    super.status,
    required super.createdAt,
    required super.updatedAt,
    super.author,
    required super.source,
    required super.schemaVersion,
    required super.contentHash,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'version': version,
      'text': text,
      'explanation': explanation,
      'difficulty': difficulty.name,
      'category': category,
      'subcategory': subcategory,
      'topic': topic,
      'type': type.name,
      'options': options
          .map((o) => {'id': o.id, 'text': o.text, 'mediaUrl': o.mediaUrl})
          .toList(),
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
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      version: json['version'],
      text: json['text'],
      explanation: json['explanation'],
      difficulty: QuestionDifficulty.values.byName(json['difficulty']),
      category: json['category'],
      subcategory: json['subcategory'],
      topic: json['topic'],
      type: QuestionType.values.byName(json['type']),
      options: (json['options'] as List)
          .map(
            (o) =>
                Answer(id: o['id'], text: o['text'], mediaUrl: o['mediaUrl']),
          )
          .toList(),
      correctAnswers: List<String>.from(json['correctAnswers']),
      tags: List<String>.from(json['tags'] ?? []),
      language: json['language'] ?? 'en',
      estimatedTime: Duration(seconds: json['estimatedTime'] ?? 30),
      xpValue: json['xpValue'] ?? 10,
      status: QuestionStatus.values.byName(json['status'] ?? 'published'),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      author: json['author'],
      source: json['source'],
      schemaVersion: json['schemaVersion'] ?? 1,
      contentHash: json['contentHash'] ?? '',
    );
  }

  /// Generates a SHA-256 hash of the question content for integrity checks.
  static String generateHash(String text, List<String> options) {
    final content = '$text${options.join()}';
    return sha256.convert(utf8.encode(content)).toString();
  }
}
