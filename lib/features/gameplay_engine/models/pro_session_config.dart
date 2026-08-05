import 'package:flutter/foundation.dart' hide Category;
import '../../question_content/domain/entities/category.dart';

enum ProDifficulty {
  intermediate,
  advanced,
  expert,
  adaptive;

  String get label => name.toUpperCase();
}

@immutable
class ProSessionConfig {
  final Category? category;
  final ProDifficulty difficulty;
  final int questionCount;
  final int entryFee;
  final bool timerEnabled;

  const ProSessionConfig({
    this.category,
    this.difficulty = ProDifficulty.intermediate,
    this.questionCount = 10,
    this.entryFee = 100,
    this.timerEnabled = true,
  });

  ProSessionConfig copyWith({
    Category? category,
    ProDifficulty? difficulty,
    int? questionCount,
    int? entryFee,
    bool? timerEnabled,
  }) {
    return ProSessionConfig(
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      entryFee: entryFee ?? this.entryFee,
      timerEnabled: timerEnabled ?? this.timerEnabled,
    );
  }
}
