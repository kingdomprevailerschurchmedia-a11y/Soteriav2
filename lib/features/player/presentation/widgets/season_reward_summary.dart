import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../domain/models/season_result.dart';
import '../../domain/models/reward_grant.dart';
import 'reward_card.dart';

class SeasonRewardSummary extends StatelessWidget {
  final SeasonResult result;
  final List<RewardGrant> rewards;
  final Function(String grantId)? onClaimReward;
  final String? claimingGrantId;

  const SeasonRewardSummary({
    super.key,
    required this.result,
    required this.rewards,
    this.onClaimReward,
    this.claimingGrantId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: SoteriaColors.elevatedSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: SoteriaColors.gold.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.goldGlow.withOpacity(0.05),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildResultGrid(),
          const SizedBox(height: 32),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'REWARDS EARNED',
              style: TextStyle(
                color: SoteriaColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (rewards.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'No rewards available for this season.',
                style: TextStyle(color: SoteriaColors.textSecondary),
              ),
            )
          else
            ...rewards.map(
              (reward) => RewardCard(
                grant: reward,
                onClaim: () => onClaimReward?.call(reward.grantId),
                isClaiming: claimingGrantId == reward.grantId,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'SEASON COMPLETE',
          style: TextStyle(
            color: SoteriaColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          result.seasonName.toUpperCase(),
          style: const TextStyle(
            color: SoteriaColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildResultGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildResultItem(
            'FINAL RANK',
            result.finalTier,
            subtitle: 'Division ${result.finalDivision}',
            icon: Icons.shield,
          ),
        ),
        Container(width: 1, height: 40, color: SoteriaColors.border),
        Expanded(
          child: _buildResultItem(
            'POSITION',
            '#${result.finalPosition}',
            subtitle: 'Global Leaderboard',
            icon: Icons.leaderboard,
            isGold: true,
          ),
        ),
      ],
    );
  }

  Widget _buildResultItem(
    String label,
    String value, {
    required String subtitle,
    required IconData icon,
    bool isGold = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: SoteriaColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isGold ? SoteriaColors.gold : SoteriaColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                color: isGold ? SoteriaColors.gold : SoteriaColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: SoteriaColors.muted, fontSize: 11),
        ),
      ],
    );
  }
}
