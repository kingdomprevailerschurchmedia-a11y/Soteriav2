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
              Row(
                children: [
                  Image.asset(
                    'assets/icons/recent_achievments.png',
                    width: 28.w,
                    height: 28.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'RECENT ACHIEVEMENTS',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      letterSpacing: 2,
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
        ),
        SizedBox(height: 6.h),
        SizedBox(
          height: 165.w,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            physics: const BouncingScrollPhysics(),
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
                description: 'Answer 10 logic questions correctly',
                date: 'May 20, 2024',
                icon: Icons.psychology_rounded,
                color: const Color(0xFF7C4DFF),
                isUnlocked: true,
              ),
              _AchievementCard(
                title: 'Century',
                description: 'Score 100 points in a single match',
                date: '',
                icon: Icons.shield_outlined,
                color: SoteriaColors.muted,
                isUnlocked: false,
                currentProgress: 72,
                totalProgress: 100,
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
    this.currentProgress = 0,
    this.totalProgress = 100,
  });

  final String title;
  final String description;
  final String date;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final int currentProgress;
  final int totalProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
      margin: EdgeInsets.only(right: 12.w),
      child: SoteriaCard(
        padding: EdgeInsets.zero,
        borderRadius: 24,
        borderColor: isUnlocked ? color.withValues(alpha: 0.3) : null,
        child: Container(
          decoration: BoxDecoration(
            gradient: isUnlocked
                ? RadialGradient(
                    center: Alignment.topCenter,
                    radius: 1.2,
                    colors: [color.withValues(alpha: 0.15), Colors.transparent],
                  )
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Subtle background stars/decoration if unlocked
              if (isUnlocked)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _StarsPainter(color: color.withValues(alpha: 0.3)),
                  ),
                ),

              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon Badge
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        gradient: isUnlocked
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  color.withValues(alpha: 0.2),
                                  color.withValues(alpha: 0.05),
                                ],
                              )
                            : null,
                        color: isUnlocked
                            ? null
                            : Colors.white.withValues(alpha: 0.03),
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (isUnlocked)
                            BoxShadow(
                              color: color.withValues(alpha: 0.2),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          isUnlocked ? icon : Icons.lock_rounded,
                          color: isUnlocked
                              ? color
                              : SoteriaColors.muted.withValues(alpha: 0.5),
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // Title
                    Text(
                      title,
                      style: context.bodyLarge.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    // Description
                    Text(
                      description,
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        fontSize: 10.sp,
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Bottom Section: Date or Progress
                    if (isUnlocked)
                      _DateBadge(date: date, color: color)
                    else
                      _ProgressBar(
                        current: currentProgress,
                        total: totalProgress,
                        color: const Color(0xFF7C4DFF),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date, required this.color});
  final String date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline_rounded, color: color, size: 12.sp),
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
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.current,
    required this.total,
    required this.color,
  });
  final int current;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final progress = (current / total).clamp(0.0, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: 4.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              height: 4.h,
              width: 80.w * progress,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.5)],
                ),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          '$current / $total',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _StarsPainter extends CustomPainter {
  _StarsPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final points = [
      Offset(size.width * 0.15, size.height * 0.25),
      Offset(size.width * 0.85, size.height * 0.35),
      Offset(size.width * 0.2, size.height * 0.45),
      Offset(size.width * 0.8, size.height * 0.15),
      Offset(size.width * 0.5, size.height * 0.1),
    ];

    for (var p in points) {
      canvas.drawCircle(p, 1.2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
