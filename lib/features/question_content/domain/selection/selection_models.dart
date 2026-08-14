import 'package:freezed_annotation/freezed_annotation.dart';
import '../entities/question.dart';
import '../entities/difficulty.dart';
import '../../../gameplay_engine/models/game_mode.dart';

part 'selection_models.freezed.dart';

@freezed
abstract class QuestionSelectionRequest with _$QuestionSelectionRequest {
  const factory QuestionSelectionRequest({
    @Default([]) List<String> categoryIds,
    @Default([]) List<String> subcategoryIds,
    @Default([]) List<String> topicIds,
    Difficulty? difficulty,
    @Default(10) int questionCount,
    @Default({}) Set<String> excludedQuestionIds,
    GameMode? mode,
    String? language,
  }) = _QuestionSelectionRequest;
}

@freezed
abstract class QuestionSelectionResult with _$QuestionSelectionResult {
  const factory QuestionSelectionResult({
    required List<Question> questions,
    required SelectionStatus status,
    @Default({}) Map<String, dynamic> metadata,
  }) = _QuestionSelectionResult;
}

enum SelectionStatus {
  success,
  insufficientContent,
  error,
}
