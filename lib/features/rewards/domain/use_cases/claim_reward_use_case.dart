import '../repositories/rewards_repository.dart';

class ClaimRewardUseCase {
  final RewardsRepository _repository;

  ClaimRewardUseCase(this._repository);

  Future<void> execute(String userId, String rewardId) async {
    // Business logic for claiming a reward:
    // 1. Validate reward exists and is claimable (usually handled by repo/backend)
    // 2. Call repository to claim
    await _repository.claimReward(userId, rewardId);
  }
}
