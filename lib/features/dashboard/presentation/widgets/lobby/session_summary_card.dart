import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../gameplay_engine/services/reward_estimator.dart';

class SessionSummaryCard extends StatelessWidget {
  const SessionSummaryCard({super.key, required this.rewards});
  final EstimatedRewards rewards;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.assignment_rounded, color: SoteriaColors.gold, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'SESSION SUMMARY',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.gold,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w900,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            'Preview your session',
                            style: context.labelSmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.4),
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white.withValues(alpha: 0.4),
                            size: 16.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SummaryItem(
                      label: 'Est. Time',
                      value: '~ ${rewards.estimatedDuration.inMinutes} min',
                      icon: Icons.timer_outlined,
                      color: const Color(0xFFB456FF),
                    ),
                    _VerticalDivider(),
                    _SummaryItem(
                      label: 'Reward',
                      value: '+ ${rewards.xp} XP',
                      icon: Icons.bolt_rounded,
                      color: SoteriaColors.gold,
                      isReward: true,
                    ),
                    _VerticalDivider(),
                    _SummaryItem(
                      label: 'Focus Area',
                      value: 'Mixed Topics',
                      icon: Icons.track_changes_rounded,
                      color: const Color(0xFF7C4DFF),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: SoteriaColors.gold.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lightbulb_outline_rounded, color: SoteriaColors.gold, size: 16),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Practice regularly to improve your accuracy and earn more XP!',
                    style: context.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 10.sp,
                      height: 1.4,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.2), size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.isReward = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isReward;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 18.sp),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.labelSmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value,
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      color: isReward ? SoteriaColors.gold : Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30.h,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }
}
