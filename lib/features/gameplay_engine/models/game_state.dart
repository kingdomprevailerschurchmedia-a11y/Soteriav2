import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

/// Immutable state of the Gameplay Engine.
class GameState {
  final String sessionId;
  final GameLifecycle lifecycle;
  final int currentQuestionIndex;
  final List<Question> questions;
  final int score;
  final int streak;
  final int lives;
  final int xp;
  final List<String> usedLifelines;
  final DateTime? startTime;
  final DateTime? lastAnswerTime;

  const GameState({
    required this.sessionId,
    this.lifecycle = GameLifecycle.initializing,
    this.currentQuestionIndex = 0,
    this.questions = const [],
    this.score = 0,
    this.streak = 0,
    this.lives = 3,
    this.xp = 0,
    this.usedLifelines = const [],
    this.startTime,
    this.lastAnswerTime,
  });

  Question? get currentQuestion =>
      questions.isNotEmpty && currentQuestionIndex < questions.length
      ? questions[currentQuestionIndex]
      : null;

  double get progress =>
      questions.isEmpty ? 0 : (currentQuestionIndex / questions.length);

  GameState copyWith({
    String? sessionId,
    GameLifecycle? lifecycle,
    int? currentQuestionIndex,
    List<Question>? questions,
    int? score,
    int? streak,
    int? lives,
    int? xp,
    List<String>? usedLifelines,
    DateTime? startTime,
    DateTime? lastAnswerTime,
  }) {
    return GameState(
      sessionId: sessionId ?? this.sessionId,
      lifecycle: lifecycle ?? this.lifecycle,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      questions: questions ?? this.questions,
      score: score ?? this.score,
      streak: streak ?? this.streak,
      lives: lives ?? this.lives,
      xp: xp ?? this.xp,
      usedLifelines: usedLifelines ?? this.usedLifelines,
      startTime: startTime ?? this.startTime,
      lastAnswerTime: lastAnswerTime ?? this.lastAnswerTime,
    );
  }
}
