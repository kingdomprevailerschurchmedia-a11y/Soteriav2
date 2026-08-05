import 'package:flutter/foundation.dart' hide Category;
import '../../question_content/domain/entities/category.dart';

enum PracticeDifficulty { beginner, intermediate, advanced, adaptive }

@immutable
class PracticeSessionConfig {
  final Category? category;
  final PracticeDifficulty difficulty;
  final int questionCount;
  final bool timerEnabled;
  final String practiceType; // standard, focus, marathon

  const PracticeSessionConfig({
    this.category,
    this.difficulty = PracticeDifficulty.beginner,
    this.questionCount = 10,
    this.timerEnabled = true,
    this.practiceType = 'standard',
  });

  PracticeSessionConfig copyWith({
    Category? category,
    PracticeDifficulty? difficulty,
    int? questionCount,
    bool? timerEnabled,
    String? practiceType,
  }) {
    return PracticeSessionConfig(
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      timerEnabled: timerEnabled ?? this.timerEnabled,
      practiceType: practiceType ?? this.practiceType,
    );
  }
}
