import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import 'package:soteria/core/design_system/components/soteria_page_wrapper.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import '../models/game_result.dart';
import '../models/competitive_session.dart';
import '../providers/competitive_results_provider.dart';
import '../providers/settlement_provider.dart';
import '../widgets/reward_summary_card.dart';
import '../widgets/settlement_card.dart';
import '../widgets/competitive_statistics_card.dart';
import '../widgets/performance_insight_card.dart';
import '../widgets/achievement_unlock_card.dart';
import '../widgets/level_progression_card.dart';
import '../../../core/firebase/providers/firebase_providers.dart';

class CompetitiveResultsScreen extends ConsumerStatefulWidget {
  final GameResult result;
  final CompetitiveSession session;
  final VoidCallback onPlayAgain;
  final VoidCallback onHome;

  const CompetitiveResultsScreen({
    super.key,
    required this.result,
    required this.session,
    required this.onPlayAgain,
    required this.onHome,
  });

  @override
  ConsumerState<CompetitiveResultsScreen> createState() =>
      _CompetitiveResultsScreenState();
}

class _CompetitiveResultsScreenState
    extends ConsumerState<CompetitiveResultsScreen> {
  @override
  void initState() {
    super.initState();
    // Start settlement immediately on entrance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(firebaseAuthServiceProvider).currentUser;
      if (user != null) {
        ref
            .read(settlementProvider.notifier)
            .finalizeSession(
              session: widget.session,
              result: widget.result,
              uid: user.uid,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(competitiveResultsProvider(widget.result));
    final isTablet = MediaQuery.of(context).size.width > 600;

    return SoteriaPageWrapper(
      title: 'Competitive Results',
      showAppBar: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
        child: isTablet ? _buildTabletLayout(data) : _buildPhoneLayout(data),
      ),
    );
  }

  Widget _buildPhoneLayout(CompetitiveResultsData data) {
    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.lg),
        _buildHeroSection(data),
        SizedBox(height: SoteriaSpacing.xl),
        LevelProgressionCard(
          initialXP: 4250, // Mock initial state
          initialLevel: 4,
          xpEarned: data.result.totalXP,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        SettlementCard(
          settlement: data.settlement,
          isProcessing: data.isProcessing,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        RewardSummaryCard(rewards: data.result.rewards),
        SizedBox(height: SoteriaSpacing.xl),
        CompetitiveStatisticsCard(result: data.result),
        SizedBox(height: SoteriaSpacing.xl),
        PerformanceInsightCard(result: data.result),
        if (data.result.accuracy >= 1.0) ...[
          SizedBox(height: SoteriaSpacing.xl),
          const AchievementUnlockCard(
            title: 'Pro Sentinel',
            description: 'Perfected a Pro Mode session.',
            icon: Icons.stars_rounded,
          ),
        ],
        SizedBox(height: SoteriaSpacing.xxl),
        _buildActionButtons(),
        SizedBox(height: SoteriaSpacing.xxxl),
      ],
    );
  }

  Widget _buildTabletLayout(CompetitiveResultsData data) {
    return Column(
      children: [
        SizedBox(height: SoteriaSpacing.xxl),
        _buildHeroSection(data),
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
                    xpEarned: data.result.totalXP,
                  ),
                  SizedBox(height: SoteriaSpacing.xl),
                  PerformanceInsightCard(result: data.result),
                  SizedBox(height: SoteriaSpacing.xl),
                  CompetitiveStatisticsCard(result: data.result),
                ],
              ),
            ),
            SizedBox(width: SoteriaSpacing.xl),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SettlementCard(
                    settlement: data.settlement,
                    isProcessing: data.isProcessing,
                  ),
                  SizedBox(height: SoteriaSpacing.xl),
                  RewardSummaryCard(rewards: data.result.rewards),
                  SizedBox(height: SoteriaSpacing.xxl),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.xxxl),
      ],
    );
  }

  Widget _buildHeroSection(CompetitiveResultsData data) {
    final accuracy = (data.result.accuracy * 100).toInt();
    final isWin = accuracy >= 70;

    return Column(
      children: [
        if (data.error != null)
          Padding(
            padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
            child: SoteriaBadge(
              label: 'SETTLEMENT ERROR: ${data.error}',
              variant: SoteriaBadgeVariant.error,
              icon: Icons.warning_rounded,
            ),
          ),
        SoteriaBadge(
          label: isWin ? 'MATCH WON' : 'MATCH LOST',
          variant: isWin
              ? SoteriaBadgeVariant.success
              : SoteriaBadgeVariant.error,
        ),
        SizedBox(height: SoteriaSpacing.lg),
        Text(
          '$accuracy%',
          style: context.displayLarge.copyWith(
            color: isWin ? SoteriaColors.success : SoteriaColors.error,
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
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SoteriaButton(
          label: 'Continue to Lobby',
          onPressed: widget.onHome,
          icon: Icons.arrow_forward_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.secondary(
          label: 'Review Answers',
          onPressed: () {
            // Navigate to Review Screen
          },
          icon: Icons.fact_check_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaButton.ghost(
          label: 'New Session',
          onPressed: widget.onPlayAgain,
        ),
      ],
    );
  }
}
