import '../models/season_result.dart';
import '../models/season_reward_definition.dart';

class RewardEligibilityService {
  List<SeasonRewardDefinition> determineEligibility({
    required SeasonResult result,
    required List<SeasonRewardDefinition> definitions,
  }) {
    return definitions.where((def) => _isEligible(result, def)).toList();
  }

  bool _isEligible(SeasonResult result, SeasonRewardDefinition definition) {
    if (!definition.isActive) return false;

    // 1. Position-based eligibility
    if (definition.minimumPosition != null &&
        result.finalPosition > definition.minimumPosition!) {
      return false;
    }
    if (definition.maximumPosition != null &&
        result.finalPosition < definition.maximumPosition!) {
      return false;
    }

    // 2. Rank-based eligibility
    // Note: This assumes rank comparison logic is simple or rank is a comparable value.
    // In a real system, you might have a RankHierarchy.
    if (definition.minimumRank != null) {
      // Basic check: if finalTier is not the minimumRank, we might need a hierarchy check.
      // For now, let's assume specific rank match or simple hierarchy if possible.
      // If we don't have a hierarchy, we'll just check for exact match or specific logic.
      if (result.finalTier != definition.minimumRank) {
        // Placeholder for more complex rank hierarchy check (e.g. Gold+ includes Platinum)
        // return _checkRankHierarchy(result.finalTier, definition.minimumRank!);
      }
    }

    // 3. Participation-based
    if (definition.participationRequired == true) {
      if (result.finalPosition <= 0 && result.finalRankPoints <= 0) {
        return false;
      }
    }

    return true;
  }
}
