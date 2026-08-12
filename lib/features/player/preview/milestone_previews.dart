import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/milestone.dart';
import '../presentation/providers/milestone_providers.dart';
import '../presentation/screens/milestones_screen.dart';

class MilestonePreviewWrapper extends StatelessWidget {
  final List<MilestoneProgress> progress;
  final bool isLoading;

  const MilestonePreviewWrapper({
    super.key,
    required this.progress,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        milestoneProgressProvider.overrideWithValue(
          isLoading ? const AsyncValue.loading() : AsyncValue.data(progress),
        ),
        milestoneEvaluationProvider.overrideWithValue(null),
      ],
      child: const MilestonesScreen(),
    );
  }
}

class MilestonePreviews {
  static List<MilestoneProgress> mockProgress() {
    return [
      MilestoneProgress(
        definition: const MilestoneDefinition(
          id: 'first_game',
          name: 'First Step',
          description: 'Complete your first competitive game.',
          type: MilestoneType.count,
          category: MilestoneCategory.participation,
          threshold: 1,
          icon: 'stars_rounded',
        ),
        playerState: PlayerMilestone(
          userId: 'u1',
          milestoneId: 'first_game',
          status: MilestoneStatus.completed,
          currentProgress: 1,
          unlockedAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
      ),
      MilestoneProgress(
        definition: const MilestoneDefinition(
          id: 'wins_10',
          name: 'Decathlon',
          description: 'Win 10 competitive games.',
          type: MilestoneType.win,
          category: MilestoneCategory.victory,
          threshold: 10,
          icon: 'military_tech_rounded',
        ),
        playerState: const PlayerMilestone(
          userId: 'u1',
          milestoneId: 'wins_10',
          status: MilestoneStatus.inProgress,
          currentProgress: 7,
        ),
      ),
      MilestoneProgress(
        definition: const MilestoneDefinition(
          id: 'rank_diamond',
          name: 'Diamond Soul',
          description: 'Reach Diamond tier.',
          type: MilestoneType.rank,
          category: MilestoneCategory.ranking,
          threshold: 1,
          icon: 'diamond_rounded',
        ),
        playerState: const PlayerMilestone(
          userId: 'u1',
          milestoneId: 'rank_diamond',
          status: MilestoneStatus.locked,
          currentProgress: 0,
        ),
      ),
    ];
  }

  static Widget gallery() => MilestonePreviewWrapper(progress: mockProgress());

  static Widget empty() => const MilestonePreviewWrapper(progress: []);

  static Widget loading() =>
      const MilestonePreviewWrapper(progress: [], isLoading: true);
}
