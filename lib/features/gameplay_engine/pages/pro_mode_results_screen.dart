import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../../core/widgets/feedback/soteria_error_widget.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../models/game_state.dart';
import '../models/pro_mode_result.dart';
import '../providers/pro_mode_results_provider.dart';

class ProModeResultsScreen extends ConsumerStatefulWidget {
  final GameState? gameState;
  final String? sessionId;

  const ProModeResultsScreen({
    super.key,
    this.gameState,
    this.sessionId,
  });

  @override
  ConsumerState<ProModeResultsScreen> createState() => _ProModeResultsScreenState();
}

class _ProModeResultsScreenState extends ConsumerState<ProModeResultsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.gameState != null) {
        ref.read(proModeResultsProvider.notifier).completeSession(widget.gameState!);
      } else if (widget.sessionId != null) {
        ref.read(proModeResultsProvider.notifier).loadResult(widget.sessionId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(proModeResultsProvider);

    return SafeGradientScaffold(
      body: state.result.when(
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SoteriaLoader(),
              SizedBox(height: 24),
              Text(
                'VERIFYING PERFORMANCE...',
                style: TextStyle(
                  color: SoteriaColors.gold,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        error: (err, st) => Center(
          child: SoteriaErrorWidget(
            message: 'AUTHORITATIVE VALIDATION FAILED',
            onRetry: () {
              if (widget.gameState != null) {
                ref
                    .read(proModeResultsProvider.notifier)
                    .completeSession(widget.gameState!);
              } else if (widget.sessionId != null) {
                ref
                    .read(proModeResultsProvider.notifier)
                    .loadResult(widget.sessionId!);
              }
            },
          ),
        ),
        data: (result) => _buildContent(context, result),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProModeResult result) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 100.w,
          leading: Center(
            child: SoteriaButton.ghost(
              label: 'EXIT',
              onPressed: () => context.go(SoteriaRoutes.proMode),
              isFullWidth: false,
              size: SoteriaButtonSize.sm,
            ),
          ),
          centerTitle: true,
          title: Text(
            'PRO MODE COMPLETE',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              if (!result.isSynced) ...[
                SizedBox(height: SoteriaSpacing.md),
                _buildSyncPendingBanner(context),
              ],
              SizedBox(height: SoteriaSpacing.xl),
              _buildRatingSection(context, result),
              SizedBox(height: SoteriaSpacing.xxl),
              _buildPrimaryMetrics(context, result),
              SizedBox(height: SoteriaSpacing.xl),
              _buildRewardSection(context, result),
              SizedBox(height: SoteriaSpacing.xl),
              _buildDetailedMetrics(context, result),
              SizedBox(height: SoteriaSpacing.xxl),
              _buildActions(context, result),
              SizedBox(height: SoteriaSpacing.xxxl),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSyncPendingBanner(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.sync_problem_rounded, color: SoteriaColors.gold, size: 16.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'OFFLINE: SYNC PENDING',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context, ProModeResult result) {
    return Semantics(
      label: 'Performance Rating: ${result.rating}',
      child: Column(
        children: [
          SoteriaScaleIn(
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: SoteriaColors.gold, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: SoteriaColors.gold.withValues(alpha: 0.3),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                result.rating,
                style: context.displayLarge.copyWith(
                  color: SoteriaColors.gold,
                  fontSize: 72.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SoteriaFadeIn(
            delay: const Duration(milliseconds: 300),
            child: Text(
              'PERFORMANCE RATING',
              style: context.labelSmall.copyWith(
                color: Colors.white38,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryMetrics(BuildContext context, ProModeResult result) {
    return SoteriaFadeIn(
      delay: const Duration(milliseconds: 500),
      child: Row(
        children: [
          Expanded(
            child: _MetricCard(
              label: 'SCORE',
              value: '${result.finalScore}',
              color: SoteriaColors.gold,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _MetricCard(
              label: 'ACCURACY',
              value: '${(result.accuracy * 100).toStringAsFixed(0)}%',
              color: SoteriaColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardSection(BuildContext context, ProModeResult result) {
    return SoteriaSlideUp(
      delay: const Duration(milliseconds: 700),
      child: SoteriaCard(
        glowColor: SoteriaColors.success,
        hasGlow: result.totalXP > 0 || result.rewards.totalCoins > 0,
        child: Column(
          children: [
            Text(
              'REWARDS EARNED',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.success,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRewardItem(
                  context,
                  Icons.bolt_rounded,
                  '${result.totalXP}',
                  'XP',
                  SoteriaColors.primary,
                ),
                Container(width: 1, height: 40.h, color: Colors.white10),
                _buildRewardItem(
                  context,
                  Icons.monetization_on_rounded,
                  '${result.rewards.totalCoins}',
                  'COINS',
                  SoteriaColors.gold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Semantics(
      label: 'Reward: $value $label',
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                value,
                style: context.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            label,
            style: context.labelSmall.copyWith(color: Colors.white38, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedMetrics(BuildContext context, ProModeResult result) {
    return SoteriaSlideUp(
      delay: const Duration(milliseconds: 900),
      child: Column(
        children: [
          _DetailedMetricRow(
            label: 'Correct Answers',
            value: '${result.correctAnswers}',
            icon: Icons.check_circle_rounded,
            color: SoteriaColors.success,
          ),
          _DetailedMetricRow(
            label: 'Wrong Answers',
            value: '${result.wrongAnswers}',
            icon: Icons.cancel_rounded,
            color: SoteriaColors.error,
          ),
          _DetailedMetricRow(
            label: 'Unanswered',
            value: '${result.skippedQuestions}',
            icon: Icons.timer_off_rounded,
            color: Colors.white38,
          ),
          _DetailedMetricRow(
            label: 'Total Time',
            value: _formatDuration(result.totalDuration),
            icon: Icons.schedule_rounded,
            color: Colors.white70,
          ),
          _DetailedMetricRow(
            label: 'Avg Response',
            value: '${(result.avgResponseTime.inMilliseconds / 1000).toStringAsFixed(2)}s',
            icon: Icons.speed_rounded,
            color: Colors.white70,
          ),
          _DetailedMetricRow(
            label: 'Fastest Answer',
            value: '${(result.fastestAnswerTime.inMilliseconds / 1000).toStringAsFixed(2)}s',
            icon: Icons.bolt_rounded,
            color: SoteriaColors.gold,
          ),
          _DetailedMetricRow(
            label: 'Slowest Answer',
            value: '${(result.slowestAnswerTime.inMilliseconds / 1000).toStringAsFixed(2)}s',
            icon: Icons.hourglass_bottom_rounded,
            color: Colors.white38,
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }

  Widget _buildActions(BuildContext context, ProModeResult result) {
    return SoteriaFadeIn(
      delay: const Duration(milliseconds: 1100),
      child: Column(
        children: [
          SoteriaButton.primary(
            label: 'PLAY AGAIN',
            onPressed: _handlePlayAgain,
            size: SoteriaButtonSize.lg,
            icon: Icons.refresh_rounded,
          ),
          SizedBox(height: SoteriaSpacing.md),
          SoteriaButton.secondary(
            label: 'REVIEW ANSWERS',
            onPressed: () {
              context.push(
                SoteriaRoutes.proReview.replaceFirst(':id', result.sessionId),
              );
            },
            size: SoteriaButtonSize.lg,
            icon: Icons.fact_check_rounded,
          ),
          SizedBox(height: SoteriaSpacing.md),
          SoteriaButton.ghost(
            label: 'RETURN TO LOBBY',
            onPressed: () => context.go(SoteriaRoutes.proMode),
            size: SoteriaButtonSize.lg,
          ),
        ],
      ),
    );
  }

  void _handlePlayAgain() async {
    // Navigate back to Pro Mode lobby to allow re-configuration and new session
    context.go(SoteriaRoutes.proMode);
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: $value',
      child: SoteriaCard(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            Text(
              value,
              style: context.headlineMedium.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: Colors.white38,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailedMetricRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _DetailedMetricRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: $value',
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18.sp),
            SizedBox(width: 12.w),
            Text(
              label,
              style: context.bodyMedium.copyWith(color: Colors.white70),
            ),
            const Spacer(),
            Text(
              value,
              style: context.labelLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
