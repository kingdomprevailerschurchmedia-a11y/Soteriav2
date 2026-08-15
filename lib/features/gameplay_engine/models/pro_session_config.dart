import 'package:flutter/foundation.dart' hide Category;
import '../../question_content/domain/entities/category.dart';
import '../../question_content/domain/entities/difficulty.dart';

enum ProDifficulty {
  intermediate,
  advanced,
  expert,
  adaptive;

  String get label => name.toUpperCase();

  Difficulty toBaseDifficulty() {
    switch (this) {
      case ProDifficulty.intermediate:
        return Difficulty.medium;
      case ProDifficulty.advanced:
        return Difficulty.hard;
      case ProDifficulty.expert:
        return Difficulty.expert;
      case ProDifficulty.adaptive:
        return Difficulty.adaptive;
    }
  }
}

@immutable
class ProSessionConfig {
  final Category? category;
  final ProDifficulty difficulty;
  final int questionCount;
  final int entryFee;
  final bool timerEnabled;
  final int minLevelRequirement;

  const ProSessionConfig({
    this.category,
    this.difficulty = ProDifficulty.intermediate,
    this.questionCount = 10,
    this.entryFee = 100,
    this.timerEnabled = true,
    this.minLevelRequirement = 1,
  });

  ProSessionConfig copyWith({
    Category? category,
    ProDifficulty? difficulty,
    int? questionCount,
    int? entryFee,
    bool? timerEnabled,
    int? minLevelRequirement,
  }) {
    return ProSessionConfig(
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      entryFee: entryFee ?? this.entryFee,
      timerEnabled: timerEnabled ?? this.timerEnabled,
      minLevelRequirement: minLevelRequirement ?? this.minLevelRequirement,
    );
  }
}
