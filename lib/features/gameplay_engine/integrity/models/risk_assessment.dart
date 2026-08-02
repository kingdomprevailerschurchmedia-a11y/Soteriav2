enum RiskLevel { low, moderate, high, critical }

/// Represents the calculated risk for a gameplay session.
class RiskAssessment {
  final double score;
  final RiskLevel level;
  final int signalCount;
  final DateTime lastEvaluated;

  const RiskAssessment({
    required this.score,
    required this.level,
    required this.signalCount,
    required this.lastEvaluated,
  });

  factory RiskAssessment.initial() => RiskAssessment(
    score: 0.0,
    level: RiskLevel.low,
    signalCount: 0,
    lastEvaluated: DateTime.now(),
  );

  RiskAssessment copyWith({
    double? score,
    RiskLevel? level,
    int? signalCount,
    DateTime? lastEvaluated,
  }) {
    return RiskAssessment(
      score: score ?? this.score,
      level: level ?? this.level,
      signalCount: signalCount ?? this.signalCount,
      lastEvaluated: lastEvaluated ?? this.lastEvaluated,
    );
  }
}
