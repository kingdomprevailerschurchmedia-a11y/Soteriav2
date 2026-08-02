import 'integrity_signal.dart';
import '../../models/game_mode.dart';

/// Defines how integrity signals are weighted and thresholds for risk levels.
abstract class IntegrityPolicy {
  double get weightMultiplier;
  Duration get backgroundGracePeriod;

  // Weights for different signal types (0.0 to 1.0)
  Map<IntegritySignalType, double> get signalWeights;

  // Thresholds for RiskLevel
  double get moderateThreshold;
  double get highThreshold;
  double get criticalThreshold;

  bool get reportToAnalytics;
  bool get collectDetailedLogs;
}

class PracticeIntegrityPolicy implements IntegrityPolicy {
  @override
  double get weightMultiplier => 0.2;
  @override
  Duration get backgroundGracePeriod => const Duration(seconds: 30);

  @override
  Map<IntegritySignalType, double> get signalWeights => {
    IntegritySignalType.appBackgrounded: 0.1,
    IntegritySignalType.tooFastAnswer: 0.05,
  };

  @override
  double get moderateThreshold => 5.0;
  @override
  double get highThreshold => 10.0;
  @override
  double get criticalThreshold => 20.0;

  @override
  bool get reportToAnalytics => false;
  @override
  bool get collectDetailedLogs => false;
}

class ProIntegrityPolicy implements IntegrityPolicy {
  @override
  double get weightMultiplier => 1.0;
  @override
  Duration get backgroundGracePeriod => const Duration(seconds: 10);

  @override
  Map<IntegritySignalType, double> get signalWeights => {
    IntegritySignalType.appBackgrounded: 0.3,
    IntegritySignalType.repeatedBackgroundSwitch: 0.8,
    IntegritySignalType.tooFastAnswer: 0.4,
    IntegritySignalType.impossibleResponseTime: 0.9,
    IntegritySignalType.clockDriftDetected: 1.0,
  };

  @override
  double get moderateThreshold => 2.0;
  @override
  double get highThreshold => 5.0;
  @override
  double get criticalThreshold => 10.0;

  @override
  bool get reportToAnalytics => true;
  @override
  bool get collectDetailedLogs => true;
}

class IntegrityPolicyResolver {
  static IntegrityPolicy resolve(GameMode mode) {
    switch (mode) {
      case GameMode.practice:
        return PracticeIntegrityPolicy();
      default:
        return ProIntegrityPolicy();
    }
  }
}
