import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/milestone.dart';

class AchievementSummarySection extends StatelessWidget {
  final List<PlayerMilestone> completed;
  final int total;
  final VoidCallback? onViewAll;

  const AchievementSummarySection({
    super.key,
    required this.completed,
    required this.total,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ACHIEVEMENTS',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 1.5,
              ),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                '$total TOTAL',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.md),
        if (completed.isEmpty)
          SoteriaCard(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: Center(
              child: Text(
                'No achievements unlocked yet.',
                style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
              ),
            ),
          )
        else
          SizedBox(
            height: 64.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: completed.length,
              separatorBuilder: (_, __) => SizedBox(width: SoteriaSpacing.md),
              itemBuilder: (context, index) {
                final milestone = completed[index];
                return _AchievementBadge(milestone: milestone);
              },
            ),
          ),
      ],
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final PlayerMilestone milestone;

  const _AchievementBadge({required this.milestone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.2)),
      ),
      child: Icon(
        Icons.emoji_events_rounded,
        color: SoteriaColors.gold,
        size: 24.sp,
      ),
    );
  }
}
