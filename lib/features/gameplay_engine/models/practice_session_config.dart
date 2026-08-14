import 'package:freezed_annotation/freezed_annotation.dart';
import '../../question_content/domain/entities/difficulty.dart';
import '../../question_content/domain/entities/category.dart';

part 'practice_session_config.freezed.dart';

@freezed
abstract class PracticeSessionConfig with _$PracticeSessionConfig {
  const factory PracticeSessionConfig({
    Category? category,
    @Default([]) List<String> categoryIds,
    @Default(Difficulty.medium) Difficulty difficulty,
    @Default(10) int questionCount,
    @Default(true) bool timerEnabled,
    @Default('standard') String practiceType, // standard, focus, marathon
    @Default(true) bool useInterests,
  }) = _PracticeSessionConfig;

  const PracticeSessionConfig._();
}
