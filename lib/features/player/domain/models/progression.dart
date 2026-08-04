import 'package:flutter/foundation.dart';

@immutable
class Progression {
  final int level;
  final int currentXp;
  final int nextLevelXp;
  final int xpInCurrentLevel;
  final double progressPercentage;
  final int xpRemaining;
  final double profileCompletion;

  const Progression({
    required this.level,
    required this.currentXp,
    required this.nextLevelXp,
    required this.xpInCurrentLevel,
    required this.progressPercentage,
    required this.xpRemaining,
    this.profileCompletion = 0.0,
  });

  factory Progression.initial() {
    return const Progression(
      level: 1,
      currentXp: 0,
      nextLevelXp: 1000,
      xpInCurrentLevel: 0,
      progressPercentage: 0.0,
      xpRemaining: 1000,
      profileCompletion: 0.0,
    );
  }
}
