import '../models/question_dto.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/difficulty.dart';

class QuestionMapper {
  static Question fromDto(QuestionDto dto) {
    return Question(
      id: dto.id,
      text: dto.text,
      explanation: dto.explanation,
      difficulty: Difficulty.values.byName(dto.difficulty),
      categoryId: dto.categoryId,
      subcategoryId: dto.subcategoryId,
      topicId: dto.topicId,
      type: QuestionType.values.byName(dto.type),
      options: dto.options.map((o) => Answer(
        id: o.id,
        text: o.text,
        mediaUrl: o.mediaUrl,
        displayOrder: o.displayOrder,
      )).toList(),
      correctOptionIds: dto.correctOptionIds,
      tags: dto.tags,
      language: dto.language,
      estimatedTime: Duration(seconds: dto.estimatedTimeSeconds),
      xpValue: dto.xpValue,
      coinValue: dto.coinValue,
      status: QuestionStatus.values.byName(dto.status),
      version: dto.version,
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
      author: dto.author,
      source: dto.source,
      schemaVersion: dto.schemaVersion,
      contentHash: dto.contentHash,
      metadata: dto.metadata,
    );
  }

  static QuestionDto toDto(Question entity) {
    return QuestionDto(
      id: entity.id,
      text: entity.text,
      explanation: entity.explanation,
      difficulty: entity.difficulty.name,
      categoryId: entity.categoryId,
      subcategoryId: entity.subcategoryId,
      topicId: entity.topicId,
      type: entity.type.name,
      options: entity.options.map((o) => AnswerDto(
        id: o.id,
        text: o.text,
        mediaUrl: o.mediaUrl,
        displayOrder: o.displayOrder,
      )).toList(),
      correctOptionIds: entity.correctOptionIds,
      tags: entity.tags,
      language: entity.language,
      estimatedTimeSeconds: entity.estimatedTime.inSeconds,
      xpValue: entity.xpValue,
      coinValue: entity.coinValue,
      status: entity.status.name,
      version: entity.version,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
      author: entity.author,
      source: entity.source,
      schemaVersion: entity.schemaVersion,
      contentHash: entity.contentHash,
      metadata: entity.metadata,
    );
  }

  /// Strips correct answers for client-facing payloads to prevent cheating.
  static Question stripCorrectAnswers(Question question) {
    return question.copyWith(correctOptionIds: []);
  }
}
