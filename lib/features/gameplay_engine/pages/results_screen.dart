import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import 'package:soteria/core/design_system/components/soteria_page_wrapper.dart';
import 'package:soteria/core/design_system/components/soteria_stats_widgets.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/widgets/reward_summary_card.dart';
import 'package:soteria/features/gameplay_engine/widgets/achievement_unlock_card.dart';
import 'package:soteria/features/gameplay_engine/widgets/level_progression_card.dart';
import 'package:soteria/features/gameplay_engine/widgets/session_analytics_card.dart';

class ResultsScreen extends ConsumerWidget {
  final GameResult result;
  final VoidCallback onPlayAgain;
  final VoidCallback onHome;

  const ResultsScreen({
    super.key,
    required this.result,
    required this.onPlayAgain,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return SoteriaPageWrapper(
      title: 'Session Results',
      showAppBar: true,
      body: isTablet ? _buildTabletLayout(context) : _buildPhoneLayout(context),
    );
  }

  Widget _buildPhoneLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.lg),
        _buildHeroSection(context),
        SizedBox(height: SoteriaSpacing.xl),
        LevelProgressionCard(
          initialXP: 4250,
          initialLevel: 4,
          xpEarned: result.rewards.totalXP,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        RewardSummaryCard(rewards: result.rewards),
        SizedBox(height: SoteriaSpacing.xl),
        SessionAnalyticsCard(result: result),
        if (result.accuracy >= 1.0) ...[
          SizedBox(height: SoteriaSpacing.xl),
          const AchievementUnlockCard(
            title: 'Perfect Sentinel',
            description: 'Completed a session with 100% accuracy.',
            icon: Icons.verified_user_rounded,
          ),
        ],
        SizedBox(height: SoteriaSpacing.xxl),
        _buildActionButtons(context),
        SizedBox(height: SoteriaSpacing.xxxl),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.xxl),
        _buildHeroSection(context),
        SizedBox(height: SoteriaSpacing.xxl),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  LevelProgressionCard(
                    initialXP: 4250,
                    initialLevel: 4,
                    xpEarned: result.rewards.totalXP,
                  ),
                  SizedBox(height: SoteriaSpacing.xl),
                  SessionAnalyticsCard(result: result),
                ],
              ),
            ),
            SizedBox(width: SoteriaSpacing.xl),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  RewardSummaryCard(rewards: result.rewards),
                  if (result.accuracy >= 1.0) ...[
                    SizedBox(height: SoteriaSpacing.xl),
                    const AchievementUnlockCard(
                      title: 'Perfect Sentinel',
                      description: 'Completed a session with 100% accuracy.',
                      icon: Icons.verified_user_rounded,
                    ),
                  ],
                  SizedBox(height: SoteriaSpacing.xxl),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.xxxl),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isPerfect = result.accuracy >= 1.0;

    return Semantics(
      label:
          'Session Accuracy: ${(result.accuracy * 100).toInt()}%. ${isPerfect ? 'Perfect Score achieved.' : ''}',
      child: Column(
        children: [
          if (!result.isSynced)
            Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
              child: const SoteriaBadge(
                label: 'OFFLINE: SYNC PENDING',
                variant: SoteriaBadgeVariant.warning,
                icon: Icons.cloud_off_rounded,
              ),
            ),
          if (isPerfect)
            const SoteriaBadge(
              label: 'PERFECT SCORE',
              variant: SoteriaBadgeVariant.gold,
            ),
          SizedBox(height: SoteriaSpacing.lg),
          Text(
            '${(result.accuracy * 100).toInt()}%',
            style: context.displayLarge.copyWith(
              color: isPerfect ? SoteriaColors.gold : SoteriaColors.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 84.sp,
              letterSpacing: -4,
            ),
          ),
          Text(
            'ACCURACY',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 4,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _QuickStat(
                label: 'CORRECT',
                value: result.correctAnswers.toString(),
                color: SoteriaColors.success,
              ),
              SizedBox(width: SoteriaSpacing.xxl),
              _QuickStat(
                label: 'WRONG',
                value: result.wrongAnswers.toString(),
                color: SoteriaColors.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SoteriaButton(
          label: 'Play Again',
          onPressed: onPlayAgain,
          icon: Icons.replay_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.secondary(
          label: 'Review Answers',
          onPressed: () {
            // Navigate to Answer Review
          },
          icon: Icons.fact_check_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.ghost(label: 'Back to Home', onPressed: onHome),
      ],
    );
  }
}

class _QuickStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _QuickStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            color: color,
            fontSize: 24.sp,
          ),
        ),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 10.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
