import '../models/season_reward_definition.dart';
import '../models/reward_grant.dart';

abstract class RewardRepository {
  Future<List<SeasonRewardDefinition>> getRewardDefinitions(String seasonId);

  Stream<List<RewardGrant>> watchPlayerRewards(String userId);
  Future<List<RewardGrant>> getPlayerRewards(String userId);

  Future<List<RewardGrant>> getSeasonRewards(String userId, String seasonId);
  Future<List<RewardGrant>> getPendingRewards(String userId);

  Future<void> claimReward(String grantId);
}
