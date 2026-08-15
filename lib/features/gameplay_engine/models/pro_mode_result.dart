import 'game_mode.dart';
import 'game_result.dart';
import '../progression/models/reward_summary.dart';
import '../answer/models/answer_result.dart';

/// Specialized result model for Pro Mode sessions.
class ProModeResult extends GameResult {
  final String rating;

  const ProModeResult({
    required String sessionId,
    required GameMode mode,
    required int finalScore,
    required int totalXP,
    required int totalQuestions,
    required int correctAnswers,
    required int wrongAnswers,
    int skippedQuestions = 0,
    required Duration totalDuration,
    required double accuracy,
    required int maxStreak,
    RewardSummary rewards = const RewardSummary(),
    Duration avgResponseTime = Duration.zero,
    Duration fastestAnswerTime = Duration.zero,
    Duration slowestAnswerTime = Duration.zero,
    List<AnswerResult> answers = const [],
    required DateTime timestamp,
    bool isSynced = true,
    required this.rating,
  }) : super(
         sessionId: sessionId,
         mode: mode,
         finalScore: finalScore,
         totalXP: totalXP,
         totalQuestions: totalQuestions,
         correctAnswers: correctAnswers,
         wrongAnswers: wrongAnswers,
         skippedQuestions: skippedQuestions,
         totalDuration: totalDuration,
         accuracy: accuracy,
         maxStreak: maxStreak,
         rewards: rewards,
         avgResponseTime: avgResponseTime,
         fastestAnswerTime: fastestAnswerTime,
         slowestAnswerTime: slowestAnswerTime,
         answers: answers,
         timestamp: timestamp,
         isSynced: isSynced,
       );

  factory ProModeResult.fromGameResult(GameResult result) {
    return ProModeResult(
      sessionId: result.sessionId,
      mode: result.mode,
      finalScore: result.finalScore,
      totalXP: result.totalXP,
      totalQuestions: result.totalQuestions,
      correctAnswers: result.correctAnswers,
      wrongAnswers: result.wrongAnswers,
      skippedQuestions: result.skippedQuestions,
      totalDuration: result.totalDuration,
      accuracy: result.accuracy,
      maxStreak: result.maxStreak,
      rewards: result.rewards,
      avgResponseTime: result.avgResponseTime,
      fastestAnswerTime: result.fastestAnswerTime,
      slowestAnswerTime: result.slowestAnswerTime,
      answers: result.answers,
      timestamp: result.timestamp,
      isSynced: result.isSynced,
      rating: calculateRating(result.accuracy),
    );
  }

  static String calculateRating(double accuracy) {
    if (accuracy >= 1.0) return 'S';
    if (accuracy >= 0.9) return 'A';
    if (accuracy >= 0.8) return 'B';
    if (accuracy >= 0.7) return 'C';
    return 'D';
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['rating'] = rating;
    return json;
  }

  factory ProModeResult.fromJson(Map<String, dynamic> json) {
    final base = GameResult.fromJson(json);
    return ProModeResult(
      sessionId: base.sessionId,
      mode: base.mode,
      finalScore: base.finalScore,
      totalXP: base.totalXP,
      totalQuestions: base.totalQuestions,
      correctAnswers: base.correctAnswers,
      wrongAnswers: base.wrongAnswers,
      skippedQuestions: base.skippedQuestions,
      totalDuration: base.totalDuration,
      accuracy: base.accuracy,
      maxStreak: base.maxStreak,
      rewards: base.rewards,
      avgResponseTime: base.avgResponseTime,
      fastestAnswerTime: base.fastestAnswerTime,
      slowestAnswerTime: base.slowestAnswerTime,
      answers: base.answers,
      timestamp: base.timestamp,
      isSynced: base.isSynced,
      rating: json['rating'] ?? calculateRating(base.accuracy),
    );
  }
}
