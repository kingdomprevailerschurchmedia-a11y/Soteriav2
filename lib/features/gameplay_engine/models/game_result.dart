import 'game_mode.dart';
import '../progression/models/reward_summary.dart';
import '../answer/models/answer_result.dart';

/// Final summary of a gameplay session performance.
class GameResult {
  final String sessionId;
  final String playerId;
  final GameMode mode;
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
  final DateTime timestamp;
  final bool isSynced;

  const GameResult({
    required this.sessionId,
    required this.playerId,
    required this.mode,
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
    required this.timestamp,
    this.isSynced = true,
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'playerId': playerId,
    'mode': mode.name,
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
    'timestamp': timestamp.toIso8601String(),
    'isSynced': isSynced,
  };

  factory GameResult.fromJson(Map<String, dynamic> json) => GameResult(
    sessionId: json['sessionId'],
    playerId: json['playerId'] ?? '',
    mode: GameMode.values.byName(json['mode'] ?? 'practice'),
    finalScore: (json['finalScore'] as num).toInt(),
    totalXP: (json['totalXP'] as num).toInt(),
    totalQuestions: (json['totalQuestions'] as num).toInt(),
    correctAnswers: (json['correctAnswers'] as num).toInt(),
    wrongAnswers: (json['wrongAnswers'] as num).toInt(),
    skippedQuestions: (json['skippedQuestions'] as num?)?.toInt() ?? 0,
    totalDuration: Duration(milliseconds: (json['totalDuration'] as num).toInt()),
    accuracy: (json['accuracy'] as num).toDouble(),
    maxStreak: (json['maxStreak'] as num).toInt(),
    rewards: RewardSummary.fromJson(json['rewards'] ?? {}),
    avgResponseTime: Duration(milliseconds: json['avgResponseTime'] ?? 0),
    fastestAnswerTime: Duration(milliseconds: json['fastestAnswerTime'] ?? 0),
    slowestAnswerTime: Duration(milliseconds: json['slowestAnswerTime'] ?? 0),
    answers: (json['answers'] as List?)
            ?.map((e) => AnswerResult.fromJson(e))
            .toList() ??
        [],
    timestamp: json['timestamp'] != null
        ? DateTime.parse(json['timestamp'])
        : DateTime.now(),
    isSynced: json['isSynced'] ?? true,
  );

  GameResult copyWith({
    String? sessionId,
    String? playerId,
    GameMode? mode,
    int? finalScore,
    int? totalXP,
    int? totalQuestions,
    int? correctAnswers,
    int? wrongAnswers,
    int? skippedQuestions,
    Duration? totalDuration,
    double? accuracy,
    int? maxStreak,
    RewardSummary? rewards,
    Duration? avgResponseTime,
    Duration? fastestAnswerTime,
    Duration? slowestAnswerTime,
    List<AnswerResult>? answers,
    DateTime? timestamp,
    bool? isSynced,
  }) {
    return GameResult(
      sessionId: sessionId ?? this.sessionId,
      playerId: playerId ?? this.playerId,
      mode: mode ?? this.mode,
      finalScore: finalScore ?? this.finalScore,
      totalXP: totalXP ?? this.totalXP,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      skippedQuestions: skippedQuestions ?? this.skippedQuestions,
      totalDuration: totalDuration ?? this.totalDuration,
      accuracy: accuracy ?? this.accuracy,
      maxStreak: maxStreak ?? this.maxStreak,
      rewards: rewards ?? this.rewards,
      avgResponseTime: avgResponseTime ?? this.avgResponseTime,
      fastestAnswerTime: fastestAnswerTime ?? this.fastestAnswerTime,
      slowestAnswerTime: slowestAnswerTime ?? this.slowestAnswerTime,
      answers: answers ?? this.answers,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
