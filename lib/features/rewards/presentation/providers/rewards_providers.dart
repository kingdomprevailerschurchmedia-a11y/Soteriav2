import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../../dashboard/presentation/providers/daily_bonus_provider.dart';
import '../../domain/models/wallet.dart';
import '../../domain/models/reward.dart';
import '../../domain/models/reward_transaction.dart';
import '../../domain/models/store_product.dart';
import '../../domain/repositories/rewards_repository.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/use_cases/claim_reward_use_case.dart';
import '../../data/repositories/firestore_rewards_repository.dart';
import '../../data/repositories/firestore_wallet_repository.dart';
import '../../../player/presentation/providers/progression_providers.dart';

// --- Repositories ---
final rewardsRepositoryProvider = Provider<RewardsRepository>((ref) {
  return FirestoreRewardsRepository(
    ref.watch(firestoreProvider),
    ref.watch(playerProgressionRepositoryProvider),
  );
});

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return FirestoreWalletRepository(ref.watch(firestoreProvider));
});

// --- Use Cases ---
final claimRewardUseCaseProvider = Provider<ClaimRewardUseCase>((ref) {
  return ClaimRewardUseCase(ref.watch(rewardsRepositoryProvider));
});

// --- State Providers ---

/// Watch the current user's wallet
final walletProvider = StreamProvider<Wallet>((ref) {
  final session = ref.watch(sessionProvider);
  
  if (!session.isAuthenticated || session.uid == null) {
    return Stream.value(Wallet.empty('anonymous'));
  }
  
  return ref.watch(walletRepositoryProvider).watchWallet(session.uid!);
});

/// Available rewards for the user
final availableRewardsProvider = FutureProvider<List<Reward>>((ref) async {
  final session = ref.watch(sessionProvider);
  final userId = session.uid ?? 'anonymous';
  final rewards = await ref.watch(rewardsRepositoryProvider).getAvailableRewards(userId);
  
  final dailyBonus = ref.watch(dailyBonusProvider);
  
  return rewards.map((r) {
    if (r.id == 'reward_daily_1') {
      final isAlreadyClaimedToday = dailyBonus.isAlreadyClaimedToday;
      return r.copyWith(
        amount: 100,
        status: isAlreadyClaimedToday
            ? RewardStatus.claimed
            : (dailyBonus.isClaiming
                ? RewardStatus.available // Use available for loading state
                : RewardStatus.claimable),
        claimedAt: isAlreadyClaimedToday ? dailyBonus.lastClaimTime : null,
        metadata: {...r.metadata, 'isClaiming': dailyBonus.isClaiming},
      );
    }
    return r;
  }).toList();
});

/// Transaction history for the user
final transactionHistoryProvider = FutureProvider<List<WalletTransaction>>((ref) async {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) return [];
  
  return ref.watch(walletRepositoryProvider).getTransactionHistory(session.uid!);
});

/// Available products in the store
final storeProductsProvider = FutureProvider<List<StoreProduct>>((ref) async {
  return ref.watch(walletRepositoryProvider).getStoreProducts();
});

/// Purchase state provider using a simple StateProvider to avoid undefined function errors
final purchaseStateProvider = StateProvider<AsyncValue<String?>>((ref) => const AsyncValue.data(null));

class RewardsNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> claimReward(String rewardId) async {
    state = const AsyncLoading();
    try {
      if (rewardId == 'reward_daily_1') {
        await ref.read(dailyBonusProvider.notifier).claim();
      } else {
        final session = ref.read(sessionProvider);
        final userId = session.uid ?? 'anonymous';
        await ref.read(claimRewardUseCaseProvider).execute(userId, rewardId);
      }
      
      ref.invalidate(availableRewardsProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> initiatePurchase(String productId) async {
    ref.read(purchaseStateProvider.notifier).state = const AsyncValue.loading();
    try {
      final session = ref.read(sessionProvider);
      if (!session.isAuthenticated) throw Exception('Authentication required for purchases');
      
      final txId = await ref.read(walletRepositoryProvider).initiatePurchase(session.uid!, productId);
      
      ref.read(purchaseStateProvider.notifier).state = AsyncValue.data(txId);
      ref.invalidate(transactionHistoryProvider);
    } catch (e, st) {
      ref.read(purchaseStateProvider.notifier).state = AsyncValue.error(e, st);
    }
  }
}

final rewardsNotifierProvider = AsyncNotifierProvider<RewardsNotifier, void>(
  RewardsNotifier.new,
);
