import '../models/milestone.dart';
import '../models/competitive_statistics.dart';
import '../models/player_progression.dart';
import '../models/season_result.dart';
import '../config/progression_config.dart';

class MilestoneEvaluationService {
  /// Evaluates all milestones for a user based on their current state.
  List<PlayerMilestone> evaluate({
    required String userId,
    required List<MilestoneDefinition> definitions,
    required CompetitiveStatistics statistics,
    required PlayerProgression progression,
    required CompetitiveHistory history,
    required List<PlayerMilestone> currentStates,
  }) {
    final updatedMilestones = <PlayerMilestone>[];

    for (final definition in definitions) {
      final currentState = currentStates.firstWhere(
        (m) => m.milestoneId == definition.id,
        orElse: () => PlayerMilestone(
          userId: userId,
          milestoneId: definition.id,
          status: MilestoneStatus.locked,
          currentProgress: 0.0,
        ),
      );

      // Skip already completed/claimed milestones to ensure idempotency
      if (currentState.status == MilestoneStatus.completed ||
          currentState.status == MilestoneStatus.claimed) {
        continue;
      }

      final double progress = _calculateProgress(
        definition: definition,
        statistics: statistics,
        progression: progression,
        history: history,
      );

      final isNewlyCompleted = progress >= definition.threshold;

      if (isNewlyCompleted || progress != currentState.currentProgress) {
        updatedMilestones.add(
          currentState.copyWith(
            currentProgress: progress,
            status: isNewlyCompleted
                ? MilestoneStatus.completed
                : MilestoneStatus.inProgress,
            unlockedAt: isNewlyCompleted ? DateTime.now() : null,
          ),
        );
      }
    }

    return updatedMilestones;
  }

  double _calculateProgress({
    required MilestoneDefinition definition,
    required CompetitiveStatistics statistics,
    required PlayerProgression progression,
    required CompetitiveHistory history,
  }) {
    switch (definition.type) {
      case MilestoneType.count:
        return statistics.career.gamesPlayed.toDouble();
      case MilestoneType.win:
        return statistics.career.gamesWon.toDouble();
      case MilestoneType.streak:
        return statistics.career.highestStreak.toDouble();
      case MilestoneType.rank:
        return _evaluateRankTier(
          progression.currentRankTier,
          definition.id,
        ).toDouble();
      case MilestoneType.position:
        return _evaluatePeakPosition(history, definition.threshold);
      case MilestoneType.season:
        return statistics.career.seasonsPlayed.toDouble();
      case MilestoneType.statistic:
        return statistics.career.accuracy * 100; // Example: Accuracy %
      case MilestoneType.careerBest:
        // Achieved if current rank is the best rank
        return progression.currentRank == statistics.career.bestRank ? 1.0 : 0.0;
      case MilestoneType.promotion:
        // This is tricky without event history, but we can check if they have any rank 
        // that isn't Unranked as a proxy for "First Rank/Promotion"
        return progression.currentRankTier != 'unranked' ? 1.0 : 0.0;
    }
  }

  int _evaluateRankTier(String currentTierId, String milestoneId) {
    // Mapping rank milestone IDs to ProgressionConfig display order
    final tierMap = {
      'rank_bronze': 1,
      'rank_silver': 2,
      'rank_gold': 3,
      'rank_platinum': 4,
      'rank_diamond': 5,
      'rank_master': 6,
      'rank_elite': 7,
    };

    final requiredOrder = tierMap[milestoneId] ?? 0;
    final currentOrder = ProgressionConfig.rankTiers
        .firstWhere(
          (t) => t.id.toLowerCase() == currentTierId.toLowerCase(),
          orElse: () => ProgressionConfig.rankTiers.first,
        )
        .displayOrder;

    return currentOrder >= requiredOrder ? 1 : 0;
  }

  double _evaluatePeakPosition(CompetitiveHistory history, double threshold) {
    if (history.bestResult == null) return 0.0;
    // For position milestones, threshold is usually Top X (e.g. 100)
    // Progress is binary (1 if achieved, 0 if not) for these definitions
    return (history.bestResult!.finalPosition <= threshold &&
            history.bestResult!.finalPosition > 0)
        ? threshold
        : 0.0;
  }
}
