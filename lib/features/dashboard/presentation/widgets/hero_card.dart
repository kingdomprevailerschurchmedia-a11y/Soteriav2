import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/design_system/gradients/soteria_gradients.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../player/domain/models/rank_progress.dart';

class HeroCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
            padding: EdgeInsets.all(20.w),
            borderRadius: 28,
            blur: 5.0,
            opacity: 0.02,
            borderColor: Colors.white.withValues(alpha: 0.1),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- Top Section: Current Rank ---
                    Text(
                      'CURRENT RANK:',
                      style: context.labelSmall.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                      ),
                    ),
                    AutoSizeText(
                      rankProgress != null 
                          ? rankProgress!.currentRank 
                          : 'Unranked',
                      maxLines: 1,
                      minFontSize: 14,
                      style: context.displaySmall.copyWith(
                        foreground: Paint()..shader = const LinearGradient(
                          colors: [Color(0xFF8A55FD), Color(0xFFE58C3D)],
                        ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        letterSpacing: -0.5,
                      ),
                    ),
                    
                    SizedBox(height: 8.h),
                    
                    // --- Section Label ---
                    _SectionLabel(
                      label: 'CAREER EXPERIENCE (XP)',
                      color: SoteriaColors.gold,
                    ),
                    
                    SizedBox(height: 12.h),
                    
                    // --- Bottom Section: Badge and Progress ---
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
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    '${(xpProgress * 100).toInt()}%',
                                    style: context.labelSmall.copyWith(
                                      color: SoteriaColors.gold,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              _GlowingProgressBar(
                                progress: xpProgress,
                                gradient: SoteriaGradients.xpProgress,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                '$xpInCurrentLevel / $xpThreshold XP ($xpRemaining left)',
                                style: context.labelSmall.copyWith(
                                  color: Colors.white.withValues(alpha: 0.3),
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
                
                // Streak Indicator (Top Right)
                Positioned(
                  top: -4.h,
                  right: -4.w,
                  child: _StreakSummary(streak: streak),
                ),
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
      mainAxisSize: MainAxisSize.min,
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
            color: color,
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
    final size = 74.w; // Increased from 64.w to make it slightly more prominent

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/ranks/level_$level.png',
            width: size,
            height: size,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => CustomPaint(
              size: Size(size, size),
              painter: _HexagonPainter(
                color: SoteriaColors.gold,
                glowColor: SoteriaColors.gold.withValues(alpha: 0.4),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'LVL',
                      style: context.labelSmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 9.sp, // Slightly increased
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      level.toString(),
                      style: context.displaySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 24.sp, // Slightly increased
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
      ..strokeWidth = 2.5.w;

    final innerBorderPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0.w;

    final glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Outer path
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

    // Inner path (inset slightly)
    final innerPath = Path();
    const inset = 4.0;
    innerPath.moveTo(w * 0.5, inset);
    innerPath.lineTo(w - inset, h * 0.25 + inset * 0.5);
    innerPath.lineTo(w - inset, h * 0.75 - inset * 0.5);
    innerPath.lineTo(w * 0.5, h - inset);
    innerPath.lineTo(inset, h * 0.75 - inset * 0.5);
    innerPath.lineTo(inset, h * 0.25 + inset * 0.5);
    innerPath.close();
    
    canvas.drawPath(innerPath, innerBorderPaint);
  }

  @override
  bool shouldRepaint(covariant _HexagonPainter oldDelegate) => 
      oldDelegate.color != color || oldDelegate.glowColor != glowColor;
}

class _GlowingProgressBar extends StatefulWidget {
  const _GlowingProgressBar({required this.progress, this.gradient}) : color = null;
  final double progress;
  final Color? color;
  final Gradient? gradient;

  @override
  State<_GlowingProgressBar> createState() => _GlowingProgressBarState();
}

class _GlowingProgressBarState extends State<_GlowingProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseGlowColor = widget.color ?? const Color(0xFF7C4DFF);

    return Container(
      height: 10.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progressWidth = widget.progress.clamp(0.0, 1.0);
              if (progressWidth == 0) return const SizedBox.shrink();

              return Container(
                margin: EdgeInsets.all(1.h),
                child: FractionallySizedBox(
                  widthFactor: progressWidth,
                  child: Stack(
                    children: [
                      // Base Bar
                      Container(
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: widget.color,
                          gradient: widget.gradient,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: baseGlowColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      // Moving Fluid Glow (Fluid sweep)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.transparent,
                                Colors.white.withValues(alpha: 0.05),
                                Colors.white.withValues(alpha: 0.6),
                                Colors.white.withValues(alpha: 0.05),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                              transform: _GradientSweepTransform(_controller.value),
                            ).createShader(bounds);
                          },
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GradientSweepTransform extends GradientTransform {
  final double percent;
  const _GradientSweepTransform(this.percent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (percent * 1.5 - 0.5), 0, 0);
  }
}

class _StreakSummary extends StatelessWidget {
  const _StreakSummary({required this.streak});
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/fire_icon.png',
            width: 24.sp,
            height: 24.sp,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.local_fire_department_rounded,
              color: Colors.orange,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            streak.toString(),
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}

Color _getRankColor(String? tierId) {
  switch (tierId?.toLowerCase()) {
    case 'gold':
      return SoteriaColors.gold;
    case 'platinum':
      return SoteriaColors.platinum;
    case 'diamond':
      return SoteriaColors.diamond;
    case 'master':
      return SoteriaColors.master;
    case 'elite':
      return SoteriaColors.elite;
    case 'silver':
      return SoteriaColors.silver;
    case 'bronze':
      return SoteriaColors.bronze;
    default:
      return SoteriaColors.gold;
  }
}
