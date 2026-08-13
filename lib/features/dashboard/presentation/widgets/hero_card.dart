import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/widgets/animations/animated_numeric_counter.dart';
import '../../../player/domain/models/rank_progress.dart';
import '../../../player/presentation/widgets/competitive_rank_badge.dart';
import '../../../player/presentation/widgets/rank_progress_bar.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.level,
    required this.xpInCurrentLevel,
    required this.xpThreshold,
    required this.streak,
    this.rankProgress,
    required this.xpProgress,
    required this.xpRemaining,
    this.isDoubleXp = false,
    this.onTap,
  });

  final int level;
  final int xpInCurrentLevel;
  final int xpThreshold;
  final int streak;
  final RankProgress? rankProgress;
  final double xpProgress;
  final int xpRemaining;
  final bool isDoubleXp;
  final VoidCallback? onTap;

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
            onTap: onTap,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            borderRadius: 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Row: Identity and Streak
                Row(
                  children: [
                    if (rankProgress != null) ...[
                      CompetitiveRankBadge(
                        tierId: rankProgress!.tier.id,
                        rankName: rankProgress!.currentRank,
                        size: RankBadgeSize.small,
                        hasGlow: rankProgress!.tier.displayOrder >= 3,
                      ),
                      SizedBox(width: 12.w),
                    ],
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
                          Text(
                            (rankProgress?.currentRank ?? 'UNRANKED').toUpperCase(),
                            style: context.titleMedium.copyWith(
                              color: SoteriaColors.gold,
                              fontWeight: FontWeight.w900,
                              fontSize: 18.sp,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StreakSummary(streak: streak),
                  ],
                ),
                
                SizedBox(height: 20.h),
                
                // --- XP Section: Career Level ---
                _SectionLabel(
                  label: 'CAREER EXPERIENCE (XP)',
                  color: SoteriaColors.xpColor,
                ),
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _HexagonLevelIndicator(level: level),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Level $level Progression',
                                style: context.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${(xpProgress * 100).toInt()}%',
                                style: context.labelSmall.copyWith(
                                  color: SoteriaColors.xpColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          _GlowingProgressBar(
                            progress: xpProgress,
                            color: SoteriaColors.xpColor,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '$xpInCurrentLevel / $xpThreshold XP ($xpRemaining left)',
                            style: context.labelSmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.3),
                              fontSize: 9.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (rankProgress != null) ...[
                  SizedBox(height: 20.h),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  SizedBox(height: 16.h),
                  
                  // --- RP Section: Competitive Standing ---
                  _SectionLabel(
                    label: 'COMPETITIVE STANDING (RP)',
                    color: SoteriaColors.gold,
                  ),
                  SizedBox(height: 8.h),
                  RankProgressBar(
                    progress: rankProgress!,
                    variant: RankProgressVariant.compact,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 2,
          height: 10.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: color.withValues(alpha: 0.6),
            letterSpacing: 1.5,
            fontWeight: FontWeight.w900,
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }
}

class _HexagonLevelIndicator extends StatelessWidget {
  const _HexagonLevelIndicator({required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    final size = 48.w;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _HexagonPainter(
          color: SoteriaColors.xpColor,
          glowColor: SoteriaColors.xpColor.withValues(alpha: 0.4),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'LVL',
                style: context.labelSmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 7.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                level.toString(),
                style: context.displaySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                  height: 1.0,
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
      ..color = color.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5.w;

    final glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.75);
    path.lineTo(w * 0.5, h);
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

class _GlowingProgressBar extends StatelessWidget {
  const _GlowingProgressBar({required this.progress, required this.color});
  final double progress;
  final Color color;

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
                color: color,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12.r),
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
            width: 16.sp,
            height: 16.sp,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 6.w),
          AnimatedNumericCounter(
            value: streak,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            'STREAK',
            style: context.labelSmall.copyWith(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 8.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
