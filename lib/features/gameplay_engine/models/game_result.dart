import '../progression/models/reward_summary.dart';
import '../answer/models/answer_result.dart';

/// Final summary of a gameplay session performance.
class GameResult {
  final String sessionId;
  final int finalScore;
  final int totalXP;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedQuestions;
  final Duration totalDuration;
  final double accuracy;
  final int maxStreak;
  final RewardSummary rewards;
  final Duration avgResponseTime;
  final Duration fastestAnswerTime;
  final Duration slowestAnswerTime;
  final List<AnswerResult> answers;
  final bool isSynced;

  const GameResult({
    required this.sessionId,
    required this.finalScore,
    required this.totalXP,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    this.skippedQuestions = 0,
    required this.totalDuration,
    required this.accuracy,
    required this.maxStreak,
    this.rewards = const RewardSummary(),
    this.avgResponseTime = Duration.zero,
    this.fastestAnswerTime = Duration.zero,
    this.slowestAnswerTime = Duration.zero,
    this.answers = const [],
    this.isSynced = true,
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'finalScore': finalScore,
    'totalXP': totalXP,
    'totalQuestions': totalQuestions,
    'correctAnswers': correctAnswers,
    'wrongAnswers': wrongAnswers,
    'skippedQuestions': skippedQuestions,
    'totalDuration': totalDuration.inMilliseconds,
    'accuracy': accuracy,
    'maxStreak': maxStreak,
    'rewards': rewards.toJson(),
    'avgResponseTime': avgResponseTime.inMilliseconds,
    'fastestAnswerTime': fastestAnswerTime.inMilliseconds,
    'slowestAnswerTime': slowestAnswerTime.inMilliseconds,
    'answers': answers.map((e) => e.toJson()).toList(),
    'isSynced': isSynced,
  };

  factory GameResult.fromJson(Map<String, dynamic> json) => GameResult(
    sessionId: json['sessionId'],
    finalScore: json['finalScore'],
    totalXP: json['totalXP'],
    totalQuestions: json['totalQuestions'],
    correctAnswers: json['correctAnswers'],
    wrongAnswers: json['wrongAnswers'],
    skippedQuestions: json['skippedQuestions'] ?? 0,
    totalDuration: Duration(milliseconds: json['totalDuration']),
    accuracy: json['accuracy'],
    maxStreak: json['maxStreak'],
    rewards: RewardSummary.fromJson(json['rewards'] ?? {}),
    avgResponseTime: Duration(milliseconds: json['avgResponseTime'] ?? 0),
    fastestAnswerTime: Duration(milliseconds: json['fastestAnswerTime'] ?? 0),
    slowestAnswerTime: Duration(milliseconds: json['slowestAnswerTime'] ?? 0),
    answers: (json['answers'] as List?)
            ?.map((e) => AnswerResult.fromJson(e))
            .toList() ??
        [],
    isSynced: json['isSynced'] ?? true,
  );
}
