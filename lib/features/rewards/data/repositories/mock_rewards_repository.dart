import '../../domain/models/reward.dart';
import '../../domain/repositories/rewards_repository.dart';

class MockRewardsRepository implements RewardsRepository {
  final List<Reward> _rewards = [
    Reward(
      id: 'reward_daily_1',
      title: 'Daily Reward',
      description: 'Come back tomorrow for more coins!',
      type: RewardType.coins,
      amount: 50,
      source: RewardSource.dailyLogin,
      status: RewardStatus.claimable,
    ),
    Reward(
      id: 'reward_achievement_1',
      title: 'Scholar',
      description: 'Answer 100 questions correctly.',
      type: RewardType.coins,
      amount: 100,
      source: RewardSource.achievement,
      status: RewardStatus.available,
    ),
    Reward(
      id: 'reward_streak_7',
      title: '7-Day Streak',
      description: 'Maintain a 7-day play streak.',
      type: RewardType.xp,
      amount: 250,
      source: RewardSource.streak,
      status: RewardStatus.locked,
    ),
    Reward(
      id: 'reward_tournament_1',
      title: 'Tournament Winner',
      description: '1st Place in Weekly Tournament',
      type: RewardType.coins,
      amount: 500,
      source: RewardSource.tournament,
      status: RewardStatus.claimed,
      claimedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Future<List<Reward>> getAvailableRewards(String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _rewards.where((r) => r.status != RewardStatus.claimed).toList();
  }

  @override
  Future<List<Reward>> getRewardHistory(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _rewards.where((r) => r.status == RewardStatus.claimed).toList();
  }

  @override
  Future<void> claimReward(String userId, String rewardId) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _rewards.indexWhere((r) => r.id == rewardId);
    if (index != -1) {
      _rewards[index] = _rewards[index].copyWith(
        status: RewardStatus.claimed,
        claimedAt: DateTime.now(),
      );
    }
  }
}
