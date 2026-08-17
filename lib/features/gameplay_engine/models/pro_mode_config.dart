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
  final Map<int, int> entryFees; // Deprecated: Use CompetitiveRewardConfig
  final Map<String, double> difficultyMultipliers; // Deprecated: Use CompetitiveRewardConfig
  final double riskFactor;
  final int minLevelRequirement;

  const ProModeConfig({
    required this.entryFees,
    required this.difficultyMultipliers,
    this.riskFactor = 1.0,
    this.minLevelRequirement = 1,
  });

  // Deprecated: Moving to CompetitiveRewardConfig source of truth
  factory ProModeConfig.defaults() => const ProModeConfig(
    entryFees: {}, 
    difficultyMultipliers: {},
    riskFactor: 1.0,
    minLevelRequirement: 5,
  );
}
