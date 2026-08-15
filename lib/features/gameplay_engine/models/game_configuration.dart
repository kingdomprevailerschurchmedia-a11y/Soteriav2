import 'package:flutter/foundation.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';

/// Configuration for a gameplay session, determining rules and constraints.
class GameConfiguration {
  final GameMode mode;
  final int questionCount;
  final Duration? questionTimer;
  final Duration? sessionTimer;
  final int initialLives;
  final bool allowLifelines;
  final double difficultyMultiplier;
  final int xpPerCorrectAnswer;
  final String? categoryId;
  final Map<String, dynamic> metadata;

  const GameConfiguration({
    required this.mode,
    this.questionCount = 10,
    this.questionTimer,
    this.sessionTimer,
    this.initialLives = 3,
    this.allowLifelines = true,
    this.difficultyMultiplier = 1.0,
    this.xpPerCorrectAnswer = 10,
    this.categoryId,
    this.metadata = const {},
  });

  /// Factory for a standard Practice session.
  factory GameConfiguration.practice() => const GameConfiguration(
    mode: GameMode.practice,
    questionCount: 20,
    initialLives: 999, // Effectively infinite
    allowLifelines: true,
    questionTimer: null,
  );

  /// Factory for a standard Pro session.
  factory GameConfiguration.pro() => const GameConfiguration(
    mode: GameMode.pro,
    questionCount: 15,
    initialLives: 3,
    questionTimer: Duration(seconds: 15),
    difficultyMultiplier: 1.5,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameConfiguration &&
          runtimeType == other.runtimeType &&
          mode == other.mode &&
          questionCount == other.questionCount &&
          questionTimer == other.questionTimer &&
          sessionTimer == other.sessionTimer &&
          initialLives == other.initialLives &&
          allowLifelines == other.allowLifelines &&
          difficultyMultiplier == other.difficultyMultiplier &&
          xpPerCorrectAnswer == other.xpPerCorrectAnswer &&
          categoryId == other.categoryId &&
          mapEquals(metadata, other.metadata);

  @override
  int get hashCode =>
      mode.hashCode ^
      questionCount.hashCode ^
      questionTimer.hashCode ^
      sessionTimer.hashCode ^
      initialLives.hashCode ^
      allowLifelines.hashCode ^
      difficultyMultiplier.hashCode ^
      xpPerCorrectAnswer.hashCode ^
      categoryId.hashCode ^
      Object.hashAll(metadata.keys) ^
      Object.hashAll(metadata.values);
}
