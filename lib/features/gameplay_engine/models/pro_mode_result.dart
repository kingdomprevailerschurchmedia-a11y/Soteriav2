import 'game_result.dart';

/// Specialized result model for Pro Mode sessions.
class ProModeResult extends GameResult {
  final String rating;

  const ProModeResult({
    required super.sessionId,
    required super.playerId,
    required super.mode,
    required super.finalScore,
    required super.totalXP,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.wrongAnswers,
    super.skippedQuestions,
    required super.totalDuration,
    required super.accuracy,
    required super.maxStreak,
    super.rewards,
    super.avgResponseTime,
    super.fastestAnswerTime,
    super.slowestAnswerTime,
    super.answers,
    required super.timestamp,
    super.isSynced,
    required this.rating,
  });

  factory ProModeResult.fromGameResult(GameResult result) {
    return ProModeResult(
      sessionId: result.sessionId,
      playerId: result.playerId,
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
      playerId: base.playerId,
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
