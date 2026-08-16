import '../models/reward.dart';

abstract class RewardsRepository {
  Future<List<Reward>> getAvailableRewards(String userId);
  Future<List<Reward>> getRewardHistory(String userId);
  Future<void> claimReward(String userId, String rewardId);
}
