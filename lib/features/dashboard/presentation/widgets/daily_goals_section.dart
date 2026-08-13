import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';

class DailyGoalsSection extends StatelessWidget {
  const DailyGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/daily_goals_icon_transparent.png',
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'DAILY GOALS',
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
                onTap: () {},
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
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            borderRadius: 24,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Complete 3 goals to earn bonus XP!',
                        style: context.titleMedium.copyWith(
                          color: SoteriaColors.muted,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _GoalProgressIcon(
                      icon: Icons.menu_book_rounded,
                      current: 0,
                      total: 1,
                      color: const Color(0xFF9155FD),
                    ),
                    _VerticalDivider(),
                    _GoalProgressIcon(
                      icon: Icons.flash_on_rounded,
                      current: 0,
                      total: 1,
                      color: const Color(0xFF2196F3),
                    ),
                    _VerticalDivider(),
                    _GoalProgressIcon(
                      icon: Icons.emoji_events_rounded,
                      current: 0,
                      total: 1,
                      color: const Color(0xFFFF9F43),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalProgressIcon extends StatelessWidget {
  const _GoalProgressIcon({
    required this.icon,
    required this.current,
    required this.total,
    required this.color,
  });

  final IconData icon;
  final int current;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.1),
            border: Border.all(
              color: color.withValues(alpha: 0.5),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              size: 20.sp,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          '$current/$total',
          style: context.labelSmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        height: 32.h,
        width: 1,
        color: Colors.white.withValues(alpha: 0.05),
      ),
    );
  }
}
