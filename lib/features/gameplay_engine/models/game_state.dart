import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';

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
  final List<AnswerResult> answerHistory;
  final DateTime? startTime;
  final DateTime? lastAnswerTime;
  final Map<String, dynamic> metadata;
  final bool isOffline;

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
    this.answerHistory = const [],
    this.startTime,
    this.lastAnswerTime,
    this.metadata = const {},
    this.isOffline = false,
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
    List<AnswerResult>? answerHistory,
    DateTime? startTime,
    DateTime? lastAnswerTime,
    Map<String, dynamic>? metadata,
    bool? isOffline,
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
      answerHistory: answerHistory ?? this.answerHistory,
      startTime: startTime ?? this.startTime,
      lastAnswerTime: lastAnswerTime ?? this.lastAnswerTime,
      metadata: metadata ?? this.metadata,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'lifecycle': lifecycle.name,
    'currentQuestionIndex': currentQuestionIndex,
    'questions': questions.map((e) => e.toJson()).toList(),
    'score': score,
    'streak': streak,
    'lives': lives,
    'xp': xp,
    'usedLifelines': usedLifelines,
    'answerHistory': answerHistory.map((e) => e.toJson()).toList(),
    'startTime': startTime?.toIso8601String(),
    'lastAnswerTime': lastAnswerTime?.toIso8601String(),
    'metadata': metadata,
    'isOffline': isOffline,
  };

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
    sessionId: json['sessionId'],
    lifecycle: GameLifecycle.values.byName(json['lifecycle']),
    currentQuestionIndex: json['currentQuestionIndex'],
    questions: (json['questions'] as List)
        .map((e) => Question.fromJson(e))
        .toList(),
    score: json['score'],
    streak: json['streak'],
    lives: json['lives'],
    xp: json['xp'],
    usedLifelines: List<String>.from(json['usedLifelines']),
    answerHistory:
        (json['answerHistory'] as List?)
            ?.map((e) => AnswerResult.fromJson(e))
            .toList() ??
        [],
    startTime: json['startTime'] != null
        ? DateTime.parse(json['startTime'])
        : null,
    lastAnswerTime: json['lastAnswerTime'] != null
        ? DateTime.parse(json['lastAnswerTime'])
        : null,
    metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    isOffline: json['isOffline'] ?? false,
  );
}
