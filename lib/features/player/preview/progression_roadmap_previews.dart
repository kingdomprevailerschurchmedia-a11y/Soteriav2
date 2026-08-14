import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/rank_progress.dart';
import '../domain/config/progression_config.dart';
import '../presentation/providers/rank_providers.dart';
import '../presentation/screens/competitive_progression_screen.dart';

class ProgressionRoadmapPreviewWrapper extends StatelessWidget {
  final RankProgress progress;

  const ProgressionRoadmapPreviewWrapper({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        rankProgressProvider.overrideWithValue(AsyncValue.data(progress)),
      ],
      child: const CompetitiveProgressionScreen(),
    );
  }
}

class ProgressionRoadmapPreviews {
  static RankProgress mockProgress(String tierId, int points) {
    final tier = ProgressionConfig.rankTiers.firstWhere((t) => t.id == tierId);
    return RankProgress(
      currentRank: tier.name,
      currentRP: points,
      minimumRP: tier.minPoints,
      maximumRP: tier.maxPoints,
      progressPercentage: 0.5,
      tier: tier,
      division: 2,
    );
  }

  static Widget bronze() => ProgressionRoadmapPreviewWrapper(
        progress: mockProgress('bronze', 250),
      );

  static Widget gold() => ProgressionRoadmapPreviewWrapper(
        progress: mockProgress('gold', 1500),
      );

  static Widget diamond() => ProgressionRoadmapPreviewWrapper(
        progress: mockProgress('diamond', 4200),
      );
}
