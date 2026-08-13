import 'package:flutter/material.dart';
import '../domain/models/reward_grant.dart';
import '../domain/models/season_reward_definition.dart';
import '../domain/models/season_result.dart';
import '../presentation/widgets/reward_card.dart';
import '../presentation/widgets/season_reward_summary.dart';
import '../presentation/screens/reward_history_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/providers/reward_providers.dart';
import '../domain/repositories/reward_repository.dart';

class RewardPreviews extends StatelessWidget {
  const RewardPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reward Card Types',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 16),
          RewardCard(
            grant: _mockGrant(RewardType.xp, status: GrantStatus.eligible),
          ),
          RewardCard(
            grant: _mockGrant(RewardType.coins, status: GrantStatus.granted),
          ),
          RewardCard(
            grant: _mockGrant(RewardType.tokens, status: GrantStatus.claimed),
          ),
          RewardCard(
            grant: _mockGrant(RewardType.badge, status: GrantStatus.pending),
          ),

          const SizedBox(height: 32),
          const Text(
            'Season Summary',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 16),
          SeasonRewardSummary(
            result: _mockResult(),
            rewards: [
              _mockGrant(RewardType.xp, amount: 2500),
              _mockGrant(RewardType.coins, amount: 500),
              _mockGrant(RewardType.badge, amount: 1),
            ],
          ),

          const SizedBox(height: 32),
          const Text(
            'History Screen',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 600,
            child: ProviderScope(
              overrides: [
                rewardRepositoryProvider.overrideWithValue(
                  _MockRewardRepository(),
                ),
              ],
              child: const RewardHistoryScreen(),
            ),
          ),
        ],
      ),
    );
  }

  RewardGrant _mockGrant(
    RewardType type, {
    GrantStatus status = GrantStatus.eligible,
    int amount = 100,
  }) {
    return RewardGrant(
      grantId: 'grant_${type.name}',
      rewardId: 'reward_${type.name}',
      seasonId: 'season_5',
      userId: 'user_123',
      type: type,
      amount: amount,
      status: status,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  SeasonResult _mockResult() {
    return SeasonResult(
      seasonId: 'season_5',
      userId: 'user_123',
      seasonName: 'Season 5',
      seasonNumber: 5,
      finalPosition: 127,
      finalRankPoints: 2840,
      finalTier: 'Diamond',
      finalDivision: 2,
      previousTier: 'Platinum',
      previousDivision: 1,
      rankChange: 450,
      completedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

class _MockRewardRepository implements RewardRepository {
  @override
  Future<List<SeasonRewardDefinition>> getRewardDefinitions(
    String seasonId,
  ) async => [];

  @override
  Stream<List<RewardGrant>> watchPlayerRewards(String userId) async* {
    yield [
      _mockGrant(RewardType.xp, status: GrantStatus.claimed, amount: 2500),
      _mockGrant(RewardType.coins, status: GrantStatus.claimed, amount: 500),
      _mockGrant(RewardType.tokens, status: GrantStatus.granted, amount: 50),
      _mockGrant(RewardType.badge, status: GrantStatus.eligible, amount: 1),
    ];
  }

  RewardGrant _mockGrant(
    RewardType type, {
    GrantStatus status = GrantStatus.eligible,
    int amount = 100,
  }) {
    return RewardGrant(
      grantId: 'grant_${type.name}_${DateTime.now().millisecond}',
      rewardId: 'reward_${type.name}',
      seasonId: 'season_5',
      userId: 'user_123',
      type: type,
      amount: amount,
      status: status,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    );
  }

  @override
  Future<List<RewardGrant>> getPlayerRewards(String userId) async => [];
  @override
  Future<List<RewardGrant>> getSeasonRewards(
    String userId,
    String seasonId,
  ) async => [];
  @override
  Future<List<RewardGrant>> getPendingRewards(String userId) async => [];
  @override
  Future<void> grantReward(RewardGrant grant) async {}
  @override
  Future<void> claimReward(String grantId) async {}
}
