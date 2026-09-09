import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../../../player/domain/models/milestone.dart';

class MilestoneSection extends StatelessWidget {
  final MilestoneProgress progress;

  const MilestoneSection({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SoteriaSpacing.containerPadding(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NEXT MILESTONE',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.gold,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.sp,
                ),
              ),
              GestureDetector(
                onTap: () => context.push('${SoteriaRoutes.achievements}?tab=1'),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w900,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: SoteriaColors.muted,
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
          padding: EdgeInsets.symmetric(
            horizontal: SoteriaSpacing.containerPadding(context),
          ),
          child: _DashboardMilestoneCard(
            progress: progress,
            onTap: () => context.push('${SoteriaRoutes.achievements}?tab=1'),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      borderRadius: 20,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: _buildMilestoneIcon(progress),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  progress.definition.name.toUpperCase(),
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  progress.definition.description,
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontSize: 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(progress.progressPercentage * 100).toInt()}%',
                style: context.labelSmall.copyWith(
                  color: const Color(0xFFB456FF),
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp,
                ),
              ),
              if (progress.definition.rewardAmount != null)
                Text(
                  '+${progress.definition.rewardAmount} ${progress.definition.rewardType?.name.toUpperCase()}',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneIcon(MilestoneProgress progress) {
    if (progress.definition.id == 'first_game') {
      return Image.asset(
        'assets/icons/first_step_icon.png',
        width: 28.w,
        height: 28.w,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.play_circle_outline_rounded,
          color: SoteriaColors.gold,
          size: 24.sp,
        ),
      );
    }

    if (progress.definition.id == 'streak_5') {
      return Image.asset(
        'assets/icons/fire_icon.png',
        width: 32.w,
        height: 32.w,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.local_fire_department_rounded,
          color: Colors.orange,
          size: 24.sp,
        ),
      );
    }

    return Icon(
      Icons.stars_rounded,
      color: const Color(0xFFB456FF),
      size: 24.sp,
    );
  }
}
