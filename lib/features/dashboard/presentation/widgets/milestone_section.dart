import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../player/domain/models/milestone.dart';
import '../../../player/presentation/screens/milestones_screen.dart';

class MilestoneSection extends StatelessWidget {
  final MilestoneProgress progress;

  const MilestoneSection({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/next_milestone.png',
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'NEXT MILESTONE',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MilestonesScreen()),
                ),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: context.labelSmall.copyWith(
                        color: const Color(0xFF9155FD),
                        fontWeight: FontWeight.w900,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: const Color(0xFF9155FD),
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: _DashboardMilestoneCard(
            progress: progress,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MilestonesScreen()),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashboardMilestoneCard extends StatelessWidget {
  final MilestoneProgress progress;
  final VoidCallback onTap;

  const _DashboardMilestoneCard({required this.progress, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      onTap: onTap,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(SoteriaSpacing.sm),
            decoration: BoxDecoration(
              color: SoteriaColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.stars_rounded,
              color: SoteriaColors.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  progress.definition.name.toUpperCase(),
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  progress.definition.description,
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontSize: 10.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(progress.progressPercentage * 100).toInt()}%',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (progress.definition.rewardAmount != null)
                Text(
                  '+${progress.definition.rewardAmount} ${progress.definition.rewardType?.name.toUpperCase()}',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
