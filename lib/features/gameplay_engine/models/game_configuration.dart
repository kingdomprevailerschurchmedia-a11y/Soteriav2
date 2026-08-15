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
  final bool autoAdvance;
  final bool showTimer;
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
    this.autoAdvance = true,
    this.showTimer = true,
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
    questionTimer: Duration(seconds: 60), // Practice has a longer timer
    autoAdvance: true,
    showTimer: true,
  );

  /// Factory for a standard Pro session.
  factory GameConfiguration.pro() => const GameConfiguration(
    mode: GameMode.pro,
    questionCount: 15,
    initialLives: 3,
    questionTimer: Duration(seconds: 15),
    difficultyMultiplier: 1.5,
  );

  GameConfiguration copyWith({
    GameMode? mode,
    int? questionCount,
    Duration? questionTimer,
    Duration? sessionTimer,
    int? initialLives,
    bool? allowLifelines,
    bool? autoAdvance,
    bool? showTimer,
    double? difficultyMultiplier,
    int? xpPerCorrectAnswer,
    String? categoryId,
    Map<String, dynamic>? metadata,
  }) {
    return GameConfiguration(
      mode: mode ?? this.mode,
      questionCount: questionCount ?? this.questionCount,
      questionTimer: questionTimer ?? this.questionTimer,
      sessionTimer: sessionTimer ?? this.sessionTimer,
      initialLives: initialLives ?? this.initialLives,
      allowLifelines: allowLifelines ?? this.allowLifelines,
      autoAdvance: autoAdvance ?? this.autoAdvance,
      showTimer: showTimer ?? this.showTimer,
      difficultyMultiplier: difficultyMultiplier ?? this.difficultyMultiplier,
      xpPerCorrectAnswer: xpPerCorrectAnswer ?? this.xpPerCorrectAnswer,
      categoryId: categoryId ?? this.categoryId,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Factory for a standard Tournament session.
  factory GameConfiguration.tournament({int questionCount = 10}) => GameConfiguration(
    mode: GameMode.tournament,
    questionCount: questionCount,
    initialLives: 3,
    allowLifelines: false,
    questionTimer: const Duration(seconds: 15),
    autoAdvance: true,
    showTimer: true,
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
          autoAdvance == other.autoAdvance &&
          showTimer == other.showTimer &&
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
      autoAdvance.hashCode ^
      showTimer.hashCode ^
      difficultyMultiplier.hashCode ^
      xpPerCorrectAnswer.hashCode ^
      categoryId.hashCode ^
      Object.hashAll(metadata.keys) ^
      Object.hashAll(metadata.values);
}
