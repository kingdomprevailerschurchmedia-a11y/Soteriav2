import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';

class SoteriaProgressChart extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final String label;
  final String subLabel;
  final Color? color;

  const SoteriaProgressChart({
    super.key,
    required this.value,
    required this.label,
    required this.subLabel,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progressColor = color ?? SoteriaColors.primary;

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _ProgressPainter(
              value: value,
              color: progressColor,
              backgroundColor: SoteriaColors.border.withValues(alpha: 0.1),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: SoteriaTypography.headlineLarge.copyWith(
                  color: SoteriaColors.textPrimary,
                ),
              ),
              Text(
                subLabel,
                style: SoteriaTypography.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double value;
  final Color color;
  final Color backgroundColor;

  _ProgressPainter({
    required this.value,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 8;
    const strokeWidth = 12.0;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final sweepAngle = 2 * pi * value;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
