import 'package:flutter/foundation.dart';

enum RiskLevel {
  low,
  medium,
  high,
  extreme;

  String get label => name.toUpperCase();
}

@immutable
class ProModeConfig {
  final Map<int, int> entryFees; // questionCount -> fee
  final Map<String, double> difficultyMultipliers; // difficulty -> multiplier
  final double riskFactor;
  final int minLevelRequirement;

  const ProModeConfig({
    required this.entryFees,
    required this.difficultyMultipliers,
    this.riskFactor = 1.0,
    this.minLevelRequirement = 1,
  });

  factory ProModeConfig.defaults() => const ProModeConfig(
    entryFees: {10: 100, 20: 250, 30: 500, 50: 1000},
    difficultyMultipliers: {
      'intermediate': 1.2,
      'advanced': 1.5,
      'expert': 2.0,
      'adaptive': 1.8,
    },
    riskFactor: 1.0,
    minLevelRequirement: 5,
  );
}
