import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../domain/models/competitive_goal.dart';
import '../widgets/goals/competitive_goal_card.dart';

class GoalDetailsScreen extends ConsumerWidget {
  final CompetitiveGoal goal;

  const GoalDetailsScreen({super.key, required this.goal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('GOAL DETAILS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            SizedBox(height: SoteriaSpacing.xxl),
            _buildProgressSection(context),
            SizedBox(height: SoteriaSpacing.xxl),
            _buildMetaSection(context),
            SizedBox(height: SoteriaSpacing.xxxl),
            if (goal.status == GoalStatus.active)
              _buildActions(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          _getIconForCategory(goal.category),
          size: 64.w,
          color: SoteriaColors.primary,
        ),
        SizedBox(height: SoteriaSpacing.md),
        Text(
          goal.title.toUpperCase(),
          style: context.headlineMedium.copyWith(fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Text(
          goal.description,
          style: context.bodyMedium.copyWith(color: SoteriaColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(SoteriaSpacing.lg),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PROGRESS', style: context.labelSmall),
              Text(
                '${(goal.progressPercentage * 100).toInt()}%',
                style: context.titleMedium.copyWith(color: SoteriaColors.primary),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          LinearProgressIndicator(
            value: goal.progressPercentage,
            backgroundColor: SoteriaColors.border,
            color: SoteriaColors.primary,
            minHeight: 12.h,
            borderRadius: BorderRadius.circular(6.r),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ProgressStat(
                label: 'CURRENT',
                value: _formatValue(goal.category, goal.currentProgress),
              ),
              _ProgressStat(
                label: 'TARGET',
                value: _formatValue(goal.category, goal.target),
              ),
              _ProgressStat(
                label: 'REMAINING',
                value: _formatValue(goal.category, goal.remaining),
                highlight: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MetaItem(
          label: 'TYPE',
          value: goal.type.name.toUpperCase(),
        ),
        _MetaItem(
          label: 'DEADLINE',
          value: DateFormat('MMM d, yyyy HH:mm').format(goal.endAt),
          isWarning: goal.remaining < (goal.target * 0.2),
        ),
        if (goal.seasonId != null)
          _MetaItem(
            label: 'SEASON',
            value: goal.seasonId!,
          ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          // Implement cancellation if needed
        },
        icon: const Icon(Icons.cancel_outlined, color: SoteriaColors.error),
        label: Text('CANCEL GOAL', style: context.labelSmall.copyWith(color: SoteriaColors.error)),
      ),
    );
  }

  IconData _getIconForCategory(GoalCategory category) {
    switch (category) {
      case GoalCategory.win: return Icons.emoji_events_rounded;
      case GoalCategory.gameCount: return Icons.sports_esports_rounded;
      case GoalCategory.rank: return Icons.military_tech_rounded;
      case GoalCategory.score: return Icons.analytics_rounded;
      case GoalCategory.streak: return Icons.local_fire_department_rounded;
      case GoalCategory.achievement: return Icons.stars_rounded;
      case GoalCategory.personalBest: return Icons.auto_awesome_rounded;
    }
  }

  String _formatValue(GoalCategory category, double value) {
    if (category == GoalCategory.personalBest && value < 1.0) {
      return '${(value * 100).toInt()}%';
    }
    return value.toInt().toString();
  }
}

class _ProgressStat extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _ProgressStat({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: context.labelSmall.copyWith(fontSize: 10.sp)),
        SizedBox(height: SoteriaSpacing.xs),
        Text(
          value,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: highlight ? SoteriaColors.secondary : SoteriaColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isWarning;

  const _MetaItem({
    required this.label,
    required this.value,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.labelSmall.copyWith(color: SoteriaColors.textSecondary)),
          Text(
            value,
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: isWarning ? SoteriaColors.warning : SoteriaColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
