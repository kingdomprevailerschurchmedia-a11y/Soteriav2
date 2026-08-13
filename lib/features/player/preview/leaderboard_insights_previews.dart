import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';
import 'package:soteria/features/player/domain/models/rank_movement_event.dart';
import 'package:soteria/features/player/domain/services/leaderboard_insights_service.dart';
import '../presentation/providers/leaderboard_providers.dart';
import '../presentation/widgets/leaderboard/player_leaderboard_position_card.dart';
import '../presentation/widgets/leaderboard/leaderboard_neighborhood.dart';
import '../presentation/widgets/leaderboard/rank_progress_card.dart';
import '../presentation/widgets/leaderboard/leaderboard_insight_card.dart';

class LeaderboardInsightsPreviews {
  static LeaderboardEntry mockEntry({
    int position = 115,
    int points = 2895,
    String tier = 'Platinum',
  }) {
    return LeaderboardEntry(
      userId: 'u1',
      displayName: 'You',
      rankPoints: points,
      rankTier: tier,
      division: 2,
      position: position,
      lastUpdated: DateTime.now(),
    );
  }

  static RankMovementEvent mockMovement({int delta = 12}) {
    return RankMovementEvent(
      id: 'm1',
      userId: 'u1',
      previousPosition: 127,
      currentPosition: 115,
      positionDelta: delta,
      previousRank: 'Platinum II',
      currentRank: 'Platinum II',
      rankPoints: 2895,
      type: RankMovementType.positionImproved,
      timestamp: DateTime.now(),
    );
  }

  static Widget positionCard() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PlayerLeaderboardPositionCard(
          entry: mockEntry(),
          totalPlayers: 1350,
          delta: 12,
        ),
      ),
    );
  }

  static Widget neighborhood() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LeaderboardNeighborhood(
          playerAbove: mockEntry(position: 114, points: 2902).copyWith(displayName: 'Player Above'),
          currentPlayer: mockEntry(),
          playerBelow: mockEntry(position: 116, points: 2887).copyWith(displayName: 'Player Below'),
        ),
      ),
    );
  }

  static Widget rankProgress() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RankProgressCard(
          entry: mockEntry(points: 3395, tier: 'Platinum'), // Threshold for Diamond is 3500
        ),
      ),
    );
  }

  static Widget insightCard() {
    return const Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LeaderboardInsightCard(
          insight: LeaderboardInsight(
            title: 'Elite Performer',
            description: "You're in the top 8.4% of all players!",
            type: InsightType.strongPercentile,
            isPositive: true,
          ),
        ),
      ),
    );
  }
}
