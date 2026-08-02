import '../models/integrity_signal.dart';
import '../models/integrity_policy.dart';
import '../models/risk_assessment.dart';

class IntegrityEngine {
  /// Deterministically calculates the RiskAssessment based on signals and policy.
  static RiskAssessment evaluate({
    required List<IntegritySignal> signals,
    required IntegrityPolicy policy,
  }) {
    double totalScore = 0.0;

    for (final signal in signals) {
      final baseWeight = policy.signalWeights[signal.type] ?? 0.1;

      // Apply policy multiplier and specific signal weighting
      double impact = baseWeight * policy.weightMultiplier;

      // Logic for background grace period
      if (signal.type == IntegritySignalType.appBackgrounded) {
        final duration = signal.metadata['durationMs'] as int? ?? 0;
        if (duration < policy.backgroundGracePeriod.inMilliseconds) {
          impact *= 0.1; // Minimal impact for quick switches
        }
      }

      totalScore += impact;
    }

    return RiskAssessment(
      score: totalScore,
      level: _determineLevel(totalScore, policy),
      signalCount: signals.length,
      lastEvaluated: DateTime.now(),
    );
  }

  static RiskLevel _determineLevel(double score, IntegrityPolicy policy) {
    if (score >= policy.criticalThreshold) return RiskLevel.critical;
    if (score >= policy.highThreshold) return RiskLevel.high;
    if (score >= policy.moderateThreshold) return RiskLevel.moderate;
    return RiskLevel.low;
  }
}
