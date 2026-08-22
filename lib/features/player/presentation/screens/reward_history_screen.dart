import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../providers/reward_providers.dart';
import '../widgets/reward_card.dart';

class RewardHistoryScreen extends ConsumerWidget {
  const RewardHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardsAsync = ref.watch(playerRewardsProvider);
    final claimState = ref.watch(rewardClaimControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'COMPETITIVE REWARDS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: rewardsAsync.when(
          data: (rewards) => _buildContent(context, ref, rewards, claimState),
          loading: () => const Center(
            child: CircularProgressIndicator(color: SoteriaColors.primary),
          ),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: SoteriaColors.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load rewards',
                  style: TextStyle(color: SoteriaColors.textPrimary),
                ),
                TextButton(
                  onPressed: () => ref.refresh(playerRewardsProvider),
                  child: const Text('RETRY'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> rewards,
    AsyncValue<void> claimState,
  ) {
    if (rewards.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard,
              color: SoteriaColors.muted.withValues(alpha: 0.5),
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'No rewards found',
              style: TextStyle(
                color: SoteriaColors.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Participate in competitive seasons to earn rewards.',
              style: TextStyle(color: SoteriaColors.muted, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final reward = rewards[index];
        return RewardCard(
          grant: reward,
          onClaim: () {
            ref
                .read(rewardClaimControllerProvider.notifier)
                .claim(reward.grantId);
          },
          isClaiming: claimState.isLoading,
        );
      },
    );
  }
}
