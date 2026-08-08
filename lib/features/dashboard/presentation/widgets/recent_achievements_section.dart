import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';

class RecentAchievementsSection extends StatelessWidget {
  const RecentAchievementsSection({super.key});

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
              Text(
                'RECENT ACHIEVEMENTS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.gold,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'View All',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.secondary,
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        SizedBox(
          height: 180.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            children: [
              _AchievementCard(
                title: 'First Win',
                description: 'Win your first match',
                date: 'May 20, 2024',
                icon: Icons.workspace_premium_rounded,
                color: SoteriaColors.gold,
                isUnlocked: true,
              ),
              _AchievementCard(
                title: 'Logic Master',
                description: 'Answer 10 logic\nquestions correctly',
                date: 'May 20, 2024',
                icon: Icons.psychology_rounded,
                color: SoteriaColors.primary,
                isUnlocked: true,
              ),
              _AchievementCard(
                title: 'Century',
                description: 'Score 100 points\nin a single match',
                date: '',
                icon: Icons.lock_outline_rounded,
                color: SoteriaColors.muted,
                isUnlocked: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.color,
    required this.isUnlocked,
  });

  final String title;
  final String description;
  final String date;
  final IconData icon;
  final Color color;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            if (isUnlocked)
              BoxShadow(
                color: color.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: SoteriaCard(
          padding: EdgeInsets.zero,
          borderRadius: 24,
          borderColor: isUnlocked ? color.withValues(alpha: 0.3) : null,
          child: Container(
            decoration: BoxDecoration(
              gradient: isUnlocked
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withValues(alpha: 0.12),
                        color.withValues(alpha: 0.02),
                      ],
                    )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: isUnlocked
                          ? color.withValues(alpha: 0.1)
                          : Colors.white.withValues(alpha: 0.03),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isUnlocked
                            ? color.withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: isUnlocked
                          ? color
                          : SoteriaColors.muted.withValues(alpha: 0.5),
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    title,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      color: isUnlocked
                          ? SoteriaColors.textPrimary
                          : SoteriaColors.muted,
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontSize: 10.sp,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  const Spacer(),
                  if (isUnlocked)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: color,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            date,
                            style: context.labelSmall.copyWith(
                              color: SoteriaColors.textSecondary,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
