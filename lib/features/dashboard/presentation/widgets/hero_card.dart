import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/widgets/animations/animated_numeric_counter.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.level,
    required this.xpInCurrentLevel,
    required this.xpThreshold,
    required this.coins,
    required this.rank,
    required this.progress,
    required this.xpRemaining,
    this.isDoubleXp = false,
  });

  final int level;
  final int xpInCurrentLevel;
  final int xpThreshold;
  final int coins;
  final String rank;
  final double progress;
  final int xpRemaining;
  final bool isDoubleXp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: SoteriaSlideUp(
        duration: const Duration(milliseconds: 600),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: SoteriaColors.primary.withValues(alpha: 0.1),
                blurRadius: 40,
                spreadRadius: -10,
              ),
            ],
          ),
          child: SoteriaCard(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            borderRadius: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CURRENT RANK',
                            style: context.labelSmall.copyWith(
                              color: SoteriaColors.muted,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w900,
                              fontSize: 10.sp,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              rank.toUpperCase(),
                              style: context.displaySmall.copyWith(
                                color: SoteriaColors.textPrimary,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                                fontSize: 28.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    _PremiumCoinsSummary(coins: coins),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.lg),
                Row(
                  children: [
                    _HexagonLevelIndicator(level: level),
                    SizedBox(width: SoteriaSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next unlock in $xpRemaining XP',
                            style: context.bodyMedium.copyWith(
                              color: SoteriaColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: SoteriaSpacing.sm),
                          _GlowingXPProgressBar(progress: progress),
                          SizedBox(height: SoteriaSpacing.xs),
                          Text(
                            '$xpInCurrentLevel / $xpThreshold XP',
                            style: context.labelSmall.copyWith(
                              color: SoteriaColors.muted,
                              fontWeight: FontWeight.w900,
                              fontSize: 10.sp,
                            ),
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
    return SizedBox(
      width: 64.w,
      child: AspectRatio(
        aspectRatio: 64 / 72,
        child: CustomPaint(
          painter: _HexagonPainter(
            color: SoteriaColors.primary,
            glowColor: SoteriaColors.primary.withValues(alpha: 0.5),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lvl',
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      level.toString(),
                      style: context.titleLarge.copyWith(
                        color: SoteriaColors.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

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

class _GlowingXPProgressBar extends StatelessWidget {
  const _GlowingXPProgressBar({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 6.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress.clamp(0.0, 1.0),
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [SoteriaColors.primary, SoteriaColors.secondary],
              ),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: SoteriaColors.primary.withValues(alpha: 0.5),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PremiumCoinsSummary extends StatelessWidget {
  const _PremiumCoinsSummary({required this.coins});
  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.monetization_on_rounded,
            color: SoteriaColors.gold,
            size: 16.sp,
          ),
          SizedBox(width: 6.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedNumericCounter(
                value: coins,
                style: context.titleSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  color: SoteriaColors.textPrimary,
                ),
              ),
              Text(
                'Coins',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontSize: 9.sp,
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
