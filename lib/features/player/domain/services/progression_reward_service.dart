import 'package:uuid/uuid.dart';
import '../models/milestone.dart';
import '../models/goal.dart';
import '../models/xp_transaction.dart';
import '../models/season_reward_definition.dart';
import '../config/milestone_registry.dart';
import '../config/goal_registry.dart';

class ProgressionRewardService {
  final _uuid = const Uuid();

  /// Processes a reward for a milestone.
  /// Returns an [XpTransaction] if the reward is XP, null otherwise.
  XpTransaction? processMilestoneReward({
    required String userId,
    required String milestoneId,
    required PlayerMilestone milestoneState,
  }) {
    // 1. Verify not already claimed
    if (milestoneState.claimedAt != null) return null;

    // 2. Lookup definition
    final definition = MilestoneRegistry.getById(milestoneId);
    if (definition == null || definition.rewardType != RewardType.xp) return null;

    // 3. Create XP Transaction
    return XpTransaction(
      transactionId: _uuid.v4(),
      userId: userId,
      amount: definition.rewardAmount ?? 0,
      source: XpSource.milestone,
      referenceId: milestoneId,
      createdAt: DateTime.now(),
    );
  }

  /// Processes a reward for a goal.
  /// Returns an [XpTransaction] if the reward is XP, null otherwise.
  XpTransaction? processGoalReward({
    required String userId,
    required String goalId,
    required PlayerGoal goalState,
  }) {
    // 1. Verify not already claimed and is completed
    if (goalState.claimedAt != null || !goalState.isCompleted) return null;

    // 2. Lookup definition
    final definition = GoalRegistry.getById(goalId.split('_').take(3).join('_')); // Handle dynamic IDs like daily_games_3_TIMESTAMP
    // Wait, the registry IDs are fixed. The PlayerGoal.goalId might contain the template ID or be the full ID.
    // Let's assume GoalRegistry contains the definition IDs.
    
    final defId = _resolveDefinitionId(goalId);
    final definitionObj = GoalRegistry.getById(defId);
    
    if (definitionObj == null || definitionObj.rewardType != RewardType.xp) return null;

    // 3. Create XP Transaction
    return XpTransaction(
      transactionId: _uuid.v4(),
      userId: userId,
      amount: definitionObj.rewardAmount ?? 0,
      source: XpSource.goal,
      referenceId: goalId,
      createdAt: DateTime.now(),
    );
  }

  String _resolveDefinitionId(String goalId) {
    // Example: daily_games_3_1723756800000 -> daily_games_3
    final parts = goalId.split('_');
    if (parts.length > 3 && (parts[0] == 'daily' || parts[0] == 'weekly')) {
       return parts.take(3).join('_');
    }
    return goalId;
  }
}
