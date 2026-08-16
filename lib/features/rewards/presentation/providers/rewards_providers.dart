import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../domain/models/wallet.dart';
import '../../domain/models/reward.dart';
import '../../domain/models/reward_transaction.dart';
import '../../domain/models/coin_bundle.dart';
import '../../domain/repositories/rewards_repository.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/use_cases/claim_reward_use_case.dart';
import '../../data/repositories/mock_rewards_repository.dart';
import '../../data/repositories/mock_wallet_repository.dart';

// --- Repositories ---
final rewardsRepositoryProvider = Provider<RewardsRepository>((ref) {
  // Use mock for now, can be swapped with Firebase implementation later
  return MockRewardsRepository();
});

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return MockWalletRepository();
});

// --- Use Cases ---
final claimRewardUseCaseProvider = Provider<ClaimRewardUseCase>((ref) {
  return ClaimRewardUseCase(ref.watch(rewardsRepositoryProvider));
});

// --- State Providers ---

/// Watch the current user's wallet
final walletProvider = StreamProvider<Wallet>((ref) {
  final session = ref.watch(sessionProvider);
  final userId = session.uid ?? 'anonymous';
  return ref.watch(walletRepositoryProvider).watchWallet(userId);
});

/// Available rewards for the user
final availableRewardsProvider = FutureProvider<List<Reward>>((ref) async {
  final session = ref.watch(sessionProvider);
  final userId = session.uid ?? 'anonymous';
  return ref.watch(rewardsRepositoryProvider).getAvailableRewards(userId);
});

/// Reward history for the user
final rewardHistoryProvider = FutureProvider<List<Reward>>((ref) async {
  final session = ref.watch(sessionProvider);
  final userId = session.uid ?? 'anonymous';
  return ref.watch(rewardsRepositoryProvider).getRewardHistory(userId);
});

/// Transaction history for the user
final transactionHistoryProvider = FutureProvider<List<RewardTransaction>>((ref) async {
  final session = ref.watch(sessionProvider);
  final userId = session.uid ?? 'anonymous';
  return ref.watch(walletRepositoryProvider).getTransactionHistory(userId);
});

/// Available coin bundles in the store
final coinBundlesProvider = FutureProvider<List<CoinBundle>>((ref) async {
  return ref.watch(walletRepositoryProvider).getCoinBundles();
});

/// Purchase status notifier
final purchaseStatusProvider = StateProvider<AsyncValue<String?>>((ref) => const AsyncData(null));

class RewardsController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  
  RewardsController(this._ref) : super(const AsyncData(null));

  Future<void> claimReward(String rewardId) async {
    state = const AsyncLoading();
    try {
      final session = _ref.read(sessionProvider);
      final userId = session.uid ?? 'anonymous';
      await _ref.read(claimRewardUseCaseProvider).execute(userId, rewardId);
      
      // Refresh rewards list
      _ref.invalidate(availableRewardsProvider);
      _ref.invalidate(rewardHistoryProvider);
      
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> purchaseBundle(String bundleId) async {
    _ref.read(purchaseStatusProvider.notifier).state = const AsyncLoading();
    try {
      final session = _ref.read(sessionProvider);
      final userId = session.uid ?? 'anonymous';
      final txId = await _ref.read(walletRepositoryProvider).initiatePurchase(userId, bundleId);
      
      _ref.read(purchaseStatusProvider.notifier).state = AsyncData(txId);
      _ref.invalidate(transactionHistoryProvider);
    } catch (e, st) {
      _ref.read(purchaseStatusProvider.notifier).state = AsyncError(e, st);
    }
  }
}

final rewardsControllerProvider = StateNotifierProvider<RewardsController, AsyncValue<void>>((ref) {
  return RewardsController(ref);
});
