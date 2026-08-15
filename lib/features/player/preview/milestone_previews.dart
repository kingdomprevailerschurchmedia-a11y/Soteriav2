import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/milestone.dart';
import '../domain/config/milestone_registry.dart';
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
    return MilestoneRegistry.definitions.map((def) {
      MilestoneStatus status = MilestoneStatus.locked;
      double progress = 0;
      
      if (def.id == 'first_game') {
        status = MilestoneStatus.claimed;
        progress = 1;
      } else if (def.id == 'wins_10') {
        status = MilestoneStatus.completed;
        progress = 10;
      } else if (def.id == 'wins_50') {
        status = MilestoneStatus.inProgress;
        progress = 25;
      }

      return MilestoneProgress(
        definition: def,
        playerState: PlayerMilestone(
          userId: 'u1',
          milestoneId: def.id,
          status: status,
          currentProgress: progress,
          unlockedAt: status == MilestoneStatus.completed ? DateTime.now() : null,
          claimedAt: status == MilestoneStatus.claimed ? DateTime.now() : null,
        ),
      );
    }).toList();
  }

  static Widget gallery() => MilestonePreviewWrapper(progress: mockProgress());

  static Widget empty() => const MilestonePreviewWrapper(progress: []);

  static Widget loading() =>
      const MilestonePreviewWrapper(progress: [], isLoading: true);
}
