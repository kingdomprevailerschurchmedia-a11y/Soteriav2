import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/screens/rewards_screen.dart';
import '../presentation/providers/rewards_providers.dart';
import '../data/repositories/mock_rewards_repository.dart';
import '../data/repositories/mock_wallet_repository.dart';
import '../domain/models/wallet.dart';
import '../domain/models/reward.dart';

class RewardsEconomyPreview extends StatelessWidget {
  const RewardsEconomyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const RewardsScreen();
  }

  static Widget normal() {
    return ProviderScope(
      overrides: [
        rewardsRepositoryProvider.overrideWithValue(MockRewardsRepository()),
        walletRepositoryProvider.overrideWithValue(MockWalletRepository()),
      ],
      child: const RewardsScreen(),
    );
  }

  static Widget emptyWallet() {
    return ProviderScope(
      overrides: [
        rewardsRepositoryProvider.overrideWithValue(MockRewardsRepository()),
        walletRepositoryProvider.overrideWithValue(_EmptyWalletRepository()),
      ],
      child: const RewardsScreen(),
    );
  }

  static Widget noRewards() {
    return ProviderScope(
      overrides: [
        rewardsRepositoryProvider.overrideWithValue(_NoRewardsRepository()),
        walletRepositoryProvider.overrideWithValue(MockWalletRepository()),
      ],
      child: const RewardsScreen(),
    );
  }
}

class _EmptyWalletRepository extends MockWalletRepository {
  @override
  Future<Wallet> getWallet(String userId) async {
    return const Wallet(coins: 0);
  }

  @override
  Stream<Wallet> watchWallet(String userId) async* {
    yield const Wallet(coins: 0);
  }
}

class _NoRewardsRepository extends MockRewardsRepository {
  @override
  Future<List<Reward>> getAvailableRewards(String userId) async {
    return [];
  }
}
