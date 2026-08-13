import '../models/leaderboard_entry.dart';
import '../models/rank_movement_event.dart';
import '../config/progression_config.dart';
import '../models/rank_tier.dart';

enum InsightType {
  promotion,
  careerBestPosition,
  seasonBestPosition,
  significantMovement,
  nearPromotion,
  strongPercentile,
  minorMovement,
}

class LeaderboardInsight {
  final String title;
  final String description;
  final InsightType type;
  final bool isPositive;

  const LeaderboardInsight({
    required this.title,
    required this.description,
    required this.type,
    required this.isPositive,
  });
}

class LeaderboardInsightsService {
  List<LeaderboardInsight> generateInsights({
    required LeaderboardEntry playerEntry,
    required int totalPlayers,
    required List<RankMovementEvent> history,
    LeaderboardEntry? playerAbove,
  }) {
    final insights = <LeaderboardInsight>[];

    // 1. Significant Position Movement
    if (history.isNotEmpty) {
      final latestMovement = history.first;
      if (latestMovement.positionDelta.abs() >= 10) {
        insights.add(LeaderboardInsight(
          title: latestMovement.positionDelta > 0 ? 'Surging Up!' : 'Falling Back',
          description: "You've moved ${latestMovement.positionDelta.abs()} positions in your last update.",
          type: InsightType.significantMovement,
          isPositive: latestMovement.positionDelta > 0,
        ));
      }
    }

    // 2. Percentile Insight
    if (totalPlayers >= 100) {
      final percentile = (playerEntry.position / totalPlayers) * 100;
      if (percentile <= 10) {
        insights.add(LeaderboardInsight(
          title: 'Elite Performer',
          description: "You're in the top ${percentile.toStringAsFixed(1)}% of all players!",
          type: InsightType.strongPercentile,
          isPositive: true,
        ));
      }
    }

    // 3. Near Promotion
    final currentTier = _getTierById(playerEntry.rankTier);
    if (currentTier != null) {
      final pointsToNext = currentTier.promotionThreshold - playerEntry.rankPoints;
      if (pointsToNext > 0 && pointsToNext <= 100) {
        final nextTier = _getNextTier(currentTier);
        if (nextTier != null) {
          insights.add(LeaderboardInsight(
            title: 'Rank Promotion Near',
            description: "Only $pointsToNext RP away from ${nextTier.name}!",
            type: InsightType.nearPromotion,
            isPositive: true,
          ));
        }
      }
    }

    // 4. Distance to Next Player
    if (playerAbove != null) {
      final rpDiff = playerAbove.rankPoints - playerEntry.rankPoints;
      if (rpDiff <= 20) {
        insights.add(LeaderboardInsight(
          title: 'Closing the Gap',
          description: "Just $rpDiff RP away from position #${playerAbove.position}.",
          type: InsightType.minorMovement,
          isPositive: true,
        ));
      }
    }

    // Prioritize and return top 3
    insights.sort((a, b) => a.type.index.compareTo(b.type.index));
    return insights.take(3).toList();
  }

  double calculatePercentile(int position, int totalPlayers) {
    if (totalPlayers == 0) return 0.0;
    return (position / totalPlayers) * 100;
  }

  RankTier? _getTierById(String id) {
    try {
      return ProgressionConfig.rankTiers.firstWhere((t) => t.id.toLowerCase() == id.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  RankTier? _getNextTier(RankTier current) {
    final index = ProgressionConfig.rankTiers.indexOf(current);
    if (index != -1 && index < ProgressionConfig.rankTiers.length - 1) {
      return ProgressionConfig.rankTiers[index + 1];
    }
    return null;
  }
}
