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
}
