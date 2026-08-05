class PlayerStatistics {
  final int totalQuestionsAnswered;
  final double overallAccuracy;
  final Duration totalStudyTime;
  final int averageResponseTimeMs;

  const PlayerStatistics({
    this.totalQuestionsAnswered = 0,
    this.overallAccuracy = 0.0,
    this.totalStudyTime = Duration.zero,
    this.averageResponseTimeMs = 0,
  });
}
