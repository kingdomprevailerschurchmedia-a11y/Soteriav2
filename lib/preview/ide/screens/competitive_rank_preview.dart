import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/player/presentation/screens/competitive_rank_overview_screen.dart';
import '../../../features/player/presentation/providers/rank_providers.dart';
import '../../../features/player/presentation/providers/leaderboard_providers.dart';
import '../../../features/player/presentation/providers/season_providers.dart';
import '../../../features/player/presentation/providers/milestone_providers.dart';
import '../../../features/player/presentation/providers/personal_record_providers.dart';
import '../../../features/player/providers/player_providers.dart';
import '../../../features/player/domain/models/rank_progress.dart';
import '../../../features/player/domain/models/competitive_season.dart';
import '../../../features/player/domain/models/player_profile.dart';
import '../../../features/player/domain/config/progression_config.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const CompetitiveRankPreview());
}

class CompetitiveRankPreview extends StatelessWidget {
  const CompetitiveRankPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final unrankedTier = ProgressionConfig.rankTiers.first;
    
    final mockProgress = RankProgress(
      currentRank: 'Unranked',
      currentRP: 0,
      minimumRP: 0,
      maximumRP: 99,
      progressPercentage: 0.0,
      rpToNextRank: 100,
      nextRank: 'Bronze III',
      isUnranked: true,
      tier: unrankedTier,
      division: 0,
    );

    final mockPlayer = PlayerProfile(
      uid: 'preview_user',
      displayName: 'Scholar',
      email: 'preview@soteria.com',
      photoUrl: '',
      coins: 0,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final mockMilestone = MilestoneProgress(
      definition: const MilestoneDefinition(
        id: 'first_step',
        name: 'First Step',
        description: 'Complete your first competitive match',
        type: MilestoneType.count,
        category: MilestoneCategory.participation,
        threshold: 1,
        rewardType: RewardType.coins,
        rewardAmount: 50,
        icon: 'stars_rounded',
      ),
      playerState: const PlayerMilestone(
        userId: 'preview_user',
        milestoneId: 'first_step',
        status: MilestoneStatus.inProgress,
        currentProgress: 0,
      ),
    );

    return PreviewScaffold(
      overrides: [
        rankProgressProvider.overrideWithValue(AsyncValue.data(mockProgress)),
        playerRankPositionProvider.overrideWith((ref) => Future.value(-1)),
        currentSeasonProvider.overrideWith((ref) => Future.value(null)),
        currentUserPersonalRecordsProvider.overrideWith((ref) => Future.value([])),
        nextCompetitiveMilestoneProvider.overrideWith((ref) => Future.value(mockMilestone)),
        rankHistoryProvider.overrideWith((ref) => Future.value([])),
        currentPlayerProvider.overrideWithValue(mockPlayer),
      ],
      child: const CompetitiveRankOverviewScreen(),
    );
  }
}
