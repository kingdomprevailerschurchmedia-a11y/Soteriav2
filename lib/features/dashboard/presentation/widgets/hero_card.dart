import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/widgets/animations/animated_numeric_counter.dart';

import '../../../../core/utils/soteria_responsive.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.level,
    required this.xpInCurrentLevel,
    required this.xpThreshold,
    required this.streak,
    required this.rank,
    this.rankPoints = 0,
    required this.progress,
    required this.xpRemaining,
    this.isDoubleXp = false,
  });

  final int level;
  final int xpInCurrentLevel;
  final int xpThreshold;
  final int streak;
  final String rank;
  final int rankPoints;
  final double progress;
  final int xpRemaining;
  final bool isDoubleXp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
      ),
      child: SoteriaSlideUp(
        duration: const Duration(milliseconds: 600),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: SoteriaColors.primary.withValues(alpha: 0.1),
                blurRadius: 40,
                spreadRadius: -10,
              ),
            ],
          ),
          child: SoteriaCard(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            borderRadius: 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CURRENT RANK',
                            style: context.labelSmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.4),
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w800,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              rank,
                              style: context.displaySmall.copyWith(
                                color: SoteriaColors.gold,
                                fontWeight: FontWeight.w900,
                                fontSize: 26.sp,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StreakSummary(streak: streak),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _HexagonLevelIndicator(level: level),
                    SizedBox(width: 24.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You are $xpRemaining XP\naway from Level ${level + 1}',
                            style: context.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '$xpInCurrentLevel / $xpThreshold XP',
                            style: context.labelSmall.copyWith(
                              color: SoteriaColors.primary.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w800,
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          _GlowingXPProgressBar(progress: progress),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                size: 14.sp,
                                color: Colors.white.withValues(alpha: 0.4),
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  'Earn XP to level up and unlock new challenges.',
                                  style: context.bodySmall.copyWith(
                                    color: Colors.white.withValues(alpha: 0.4),
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HexagonLevelIndicator extends StatelessWidget {
  const _HexagonLevelIndicator({required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    final size = 72.w;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _HexagonPainter(
          color: SoteriaColors.primary,
          glowColor: SoteriaColors.primary.withValues(alpha: 0.6),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lvl',
                style: context.labelSmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                level.toString(),
                style: context.displaySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 28.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  _HexagonPainter({required this.color, required this.glowColor});
  final Color color;
  final Color glowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5.w;

    final glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 12);

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Mathematically accurate regular hexagon (pointy topped)
    // Points at 0, 60, 120, 180, 240, 300 degrees
    // To fit in square: points are at (w/2, 0) and (w/2, h)
    // Horizontal span is w, but for regular it should be w * sqrt(3)/2
    // We'll use the full width for the path to keep it centered and visible.
    
    path.moveTo(w * 0.5, 0); // Top center
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.75);
    path.lineTo(w * 0.5, h); // Bottom center
    path.lineTo(0, h * 0.75);
    path.lineTo(0, h * 0.25);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GlowingXPProgressBar extends StatelessWidget {
  const _GlowingXPProgressBar({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              height: 4.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [SoteriaColors.primary, SoteriaColors.secondary],
                ),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: SoteriaColors.primary.withValues(alpha: 0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakSummary extends StatelessWidget {
  const _StreakSummary({required this.streak});
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/streak_icon.png',
            width: 20.sp,
            height: 20.sp,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 8.w),
          Container(
            height: 12.h,
            width: 1,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          SizedBox(width: 8.w),
          AnimatedNumericCounter(
            value: streak,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            'Streak',
            style: context.labelLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
