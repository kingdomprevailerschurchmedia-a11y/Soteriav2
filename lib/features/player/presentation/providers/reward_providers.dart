import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/reward_grant.dart';
import '../../domain/models/season_reward_definition.dart';
import '../../domain/repositories/reward_repository.dart';
import '../../data/repositories/firebase_reward_repository.dart';
import '../../../auth/providers/auth_providers.dart';

final rewardRepositoryProvider = Provider<RewardRepository>((ref) {
  return FirebaseRewardRepository(FirebaseFirestore.instance);
});

final playerRewardsProvider = StreamProvider<List<RewardGrant>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);

  return ref.watch(rewardRepositoryProvider).watchPlayerRewards(userId);
});

final seasonRewardDefinitionsProvider = FutureProvider.family<List<SeasonRewardDefinition>, String>((
  ref,
  seasonId,
) async {
  return ref.watch(rewardRepositoryProvider).getRewardDefinitions(seasonId);
});

final seasonRewardsProvider = FutureProvider.family<List<RewardGrant>, String>((
  ref,
  seasonId,
) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return [];

  return ref.watch(rewardRepositoryProvider).getSeasonRewards(userId, seasonId);
});

final pendingRewardsProvider = FutureProvider<List<RewardGrant>>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return [];

  return ref.watch(rewardRepositoryProvider).getPendingRewards(userId);
});

final rewardClaimControllerProvider =
    StateNotifierProvider<RewardClaimNotifier, AsyncValue<void>>((ref) {
      return RewardClaimNotifier(ref.watch(rewardRepositoryProvider));
    });

class RewardClaimNotifier extends StateNotifier<AsyncValue<void>> {
  final RewardRepository _repository;

  RewardClaimNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> claim(String grantId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.claimReward(grantId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final latestRewardsProvider = Provider<List<RewardGrant>>((ref) {
  final rewards = ref.watch(playerRewardsProvider).value ?? [];
  // Sort by date and take top 5
  return (List<RewardGrant>.from(
    rewards,
  )..sort((a, b) => b.createdAt.compareTo(a.createdAt))).take(5).toList();
});
