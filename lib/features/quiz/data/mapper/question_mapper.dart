import '../../domain/models/question.dart';
import '../../domain/models/answer_option.dart';
import '../../domain/models/quiz_enums.dart';
import '../dto/question_dto.dart';

class QuestionMapper {
  static Question fromDto(QuestionDto dto) {
    return Question(
      id: dto.id,
      type: QuestionType.values.firstWhere(
        (e) => e.name == dto.type,
        orElse: () => QuestionType.multipleChoice,
      ),
      category: dto.category,
      difficulty: Difficulty.values.firstWhere(
        (e) => e.name == dto.difficulty,
        orElse: () => Difficulty.easy,
      ),
      text: dto.text,
      imageUrl: dto.imageUrl,
      audioUrl: dto.audioUrl,
      videoUrl: dto.videoUrl,
      explanation: dto.explanation,
      options: dto.options.map((o) => AnswerOption.fromJson(o)).toList(),
      correctOptionIds: dto.correctOptionIds,
      tags: dto.tags,
      estimatedTime: dto.estimatedTime,
      xpValue: dto.xpValue,
      coinValue: dto.coinValue,
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
    );
  }

  static QuestionDto toDto(Question model) {
    return QuestionDto(
      id: model.id,
      type: model.type.name,
      category: model.category,
      difficulty: model.difficulty.name,
      text: model.text,
      imageUrl: model.imageUrl,
      audioUrl: model.audioUrl,
      videoUrl: model.videoUrl,
      explanation: model.explanation,
      options: model.options.map((o) => o.toJson()).toList(),
      correctOptionIds: model.correctOptionIds,
      tags: model.tags,
      estimatedTime: model.estimatedTime,
      xpValue: model.xpValue,
      coinValue: model.coinValue,
      createdAt: model.createdAt.toIso8601String(),
      updatedAt: model.updatedAt.toIso8601String(),
    );
  }
}
