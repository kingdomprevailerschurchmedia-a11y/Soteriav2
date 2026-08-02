/// Final summary of a gameplay session performance.
class GameResult {
  final String sessionId;
  final int finalScore;
  final int totalXP;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final Duration totalDuration;
  final double accuracy;
  final int maxStreak;

  const GameResult({
    required this.sessionId,
    required this.finalScore,
    required this.totalXP,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalDuration,
    required this.accuracy,
    required this.maxStreak,
  });
}
