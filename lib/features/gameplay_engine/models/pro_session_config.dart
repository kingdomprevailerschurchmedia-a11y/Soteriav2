import 'package:flutter/foundation.dart' hide Category;
import '../../question_content/domain/entities/category.dart';
import '../../question_content/domain/entities/difficulty.dart';

enum ProDifficulty {
  foundation,
  intermediate,
  advanced,
  expert,
  adaptive;

  String get label => name.toUpperCase();

  Difficulty toBaseDifficulty() {
    switch (this) {
      case ProDifficulty.foundation:
        return Difficulty.easy;
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
  final bool useInterests;

  const ProSessionConfig({
    this.category,
    this.difficulty = ProDifficulty.intermediate,
    this.questionCount = 10,
    this.entryFee = 500, // Updated to match Intermediate default
    this.timerEnabled = true,
    this.minLevelRequirement = 1,
    this.useInterests = false,
  });

  ProSessionConfig copyWith({
    Category? category,
    ProDifficulty? difficulty,
    int? questionCount,
    int? entryFee,
    bool? timerEnabled,
    int? minLevelRequirement,
    bool? useInterests,
  }) {
    return ProSessionConfig(
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      entryFee: entryFee ?? this.entryFee,
      timerEnabled: timerEnabled ?? this.timerEnabled,
      minLevelRequirement: minLevelRequirement ?? this.minLevelRequirement,
      useInterests: useInterests ?? this.useInterests,
    );
  }
}
