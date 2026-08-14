import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../providers/rank_providers.dart';
import '../../domain/config/progression_config.dart';
import '../../domain/models/rank_progress.dart';
import '../../domain/models/rank_tier.dart';
import '../widgets/competitive_rank_badge.dart';
import '../widgets/rank_progress_bar.dart';

class CompetitiveProgressionScreen extends ConsumerWidget {
  const CompetitiveProgressionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankProgressAsync = ref.watch(rankProgressProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('PROGRESSION ROADMAP'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: rankProgressAsync.when(
        data: (progress) => _buildContent(context, progress),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RankProgress currentProgress) {
    final tiers = ProgressionConfig.rankTiers;

    return ListView.builder(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      itemCount: tiers.length,
      itemBuilder: (context, index) {
        final tier = tiers[index];
        final isCurrentTier = currentProgress.tier.id == tier.id;
        final isCompleted = currentProgress.tier.displayOrder > tier.displayOrder;
        final isLocked = currentProgress.tier.displayOrder < tier.displayOrder;

        return _RankRoadmapItem(
          tier: tier,
          isCurrent: isCurrentTier,
          isCompleted: isCompleted,
          isLocked: isLocked,
          currentRP: currentProgress.currentRP,
        );
      },
    );
  }
}

class _RankRoadmapItem extends StatelessWidget {
  final RankTier tier;
  final bool isCurrent;
  final bool isCompleted;
  final bool isLocked;
  final int currentRP;

  const _RankRoadmapItem({
    required this.tier,
    required this.isCurrent,
    required this.isCompleted,
    required this.isLocked,
    required this.currentRP,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isLocked ? SoteriaColors.muted : SoteriaColors.textPrimary;
    final double opacity = isLocked ? 0.4 : 1.0;

    return Container(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.xl),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Rank Badge and Line
          Column(
            children: [
              CompetitiveRankBadge(
                tierId: tier.id,
                rankName: tier.name,
                size: isCurrent ? RankBadgeSize.large : RankBadgeSize.medium,
                hasGlow: isCurrent,
              ),
              if (tier.id != 'elite')
                Container(
                  width: 2,
                  height: 60.h,
                  color: isCompleted ? SoteriaColors.success : SoteriaColors.border,
                ),
            ],
          ),

          SizedBox(width: SoteriaSpacing.lg),

          // Right: Tier Details
          Expanded(
            child: Opacity(
              opacity: opacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tier.name.toUpperCase(),
                    style: context.titleLarge.copyWith(
                      color: isCurrent ? SoteriaColors.gold : color,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.xs),
                  Text(
                    '${tier.minPoints} - ${tier.maxPoints == 999999 ? "∞" : tier.maxPoints} RP',
                    style: context.bodySmall.copyWith(color: SoteriaColors.textSecondary),
                  ),
                  if (isCurrent) ...[
                    SizedBox(height: SoteriaSpacing.md),
                    _buildCurrentStatus(context),
                  ],
                  if (isCompleted) ...[
                    SizedBox(height: SoteriaSpacing.xs),
                    Row(
                      children: [
                        Icon(Icons.check_circle_rounded, color: SoteriaColors.success, size: 16.w),
                        SizedBox(width: SoteriaSpacing.xs),
                        Text(
                          'COMPLETED',
                          style: context.labelSmall.copyWith(color: SoteriaColors.success),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(SoteriaSpacing.md),
        border: Border.all(color: SoteriaColors.gold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CURRENTLY CLIMBING',
            style: context.labelSmall.copyWith(color: SoteriaColors.gold),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            '$currentRP RP',
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          // We could add a mini progress bar here if needed
        ],
      ),
    );
  }
}
