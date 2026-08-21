import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../domain/models/player_progression.dart';
import '../../domain/config/progression_config.dart';

class PlayerProgressionCard extends StatelessWidget {
  final PlayerProgression progression;

  const PlayerProgressionCard({
    super.key,
    required this.progression,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: GlassSurface(
        borderRadius: BorderRadius.circular(28),
        opacity: 0.05,
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _ProgressBarSection(
              icon: Icons.auto_awesome_rounded,
              label: 'XP PROGRESS',
              value: '${progression.currentXp} / ${ProgressionConfig.xpCapacityForLevel(progression.currentLevel)} XP',
              progress: progression.xpProgress,
              color: const Color(0xFF7C4DFF),
              rightWidget: const _HexagonIcon(
                text: 'XP',
                color: Color(0xFF7C4DFF),
                size: 48,
              ),
            ),
            SizedBox(height: 12.h),
            Divider(color: Colors.white.withValues(alpha: 0.05), height: 24.h),
            _ProgressBarSection(
              icon: Icons.workspace_premium_rounded,
              label: 'RANK PROGRESS',
              value: '${(progression.rankProgress * 100).toInt()}%',
              progress: progression.rankProgress,
              color: SoteriaColors.gold,
              rightWidget: const _HexagonIcon(
                icon: Icons.lock_rounded,
                color: Color(0xFF1E1638),
                borderColor: Colors.white10,
                size: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBarSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double progress;
  final Color color;
  final Widget rightWidget;

  const _ProgressBarSection({
    required this.icon,
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
    required this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 14.sp),
                  SizedBox(width: 8.w),
                  Text(
                    label,
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.textSecondary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: value.split(' / ').first,
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.w900,
                        color: color,
                        fontSize: 22.sp,
                      ),
                    ),
                    if (value.contains(' / ')) ...[
                      TextSpan(
                        text: ' / ${value.split(' / ').last}',
                        style: context.bodyLarge.copyWith(
                          color: SoteriaColors.muted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              SoteriaProgressBar(
                progress: progress,
                color: color.withValues(alpha: 0.8),
                height: 6.h,
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        rightWidget,
      ],
    );
  }
}

class _HexagonIcon extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color color;
  final Color? borderColor;
  final double size;

  const _HexagonIcon({
    this.text,
    this.icon,
    required this.color,
    this.borderColor,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: (size * 1.13).h,
      child: CustomPaint(
        painter: _HexagonPainter(
          color: color,
          borderColor: borderColor ?? color.withValues(alpha: 0.5),
        ),
        child: Center(
          child: text != null
              ? Text(
                  text!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: (size * 0.3).sp,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.white.withValues(alpha: 0.2),
                  size: (size * 0.4).sp,
                ),
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  _HexagonPainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    final path = Path();
    for (int i = 0; i < 6; i++) {
      double angle = 2 * math.pi / 6 * i - math.pi / 2;
      double x = centerX + radius * math.cos(angle);
      double y = centerY + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Fill with gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color,
          color.withValues(alpha: 0.6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    canvas.drawPath(path, fillPaint);

    // Border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, borderPaint);

    // Inner bevel effect
    final bevelPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.2),
          Colors.transparent,
          Colors.black.withValues(alpha: 0.1),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, bevelPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
