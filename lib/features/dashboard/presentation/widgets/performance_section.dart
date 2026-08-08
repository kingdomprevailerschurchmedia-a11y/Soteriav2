import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';

class PerformanceSection extends StatelessWidget {
  const PerformanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights_rounded,
                color: SoteriaColors.secondary,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'PERFORMANCE',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.textSecondary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xl),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.3,
            children: [
              _PerformanceCard(
                title: 'Answered',
                value: '1,250',
                icon: Icons.quiz_rounded,
                color: Colors.deepPurpleAccent,
                data: [0.2, 0.4, 0.3, 0.7, 0.5, 0.8],
              ),
              _PerformanceCard(
                title: 'Accuracy',
                value: '85%',
                icon: Icons.track_changes_rounded,
                color: Colors.greenAccent,
                data: [0.6, 0.5, 0.8, 0.7, 0.9, 0.85],
              ),
              _PerformanceCard(
                title: 'Matches',
                value: '142',
                icon: Icons.sports_esports_rounded,
                color: Colors.blueAccent,
                data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.6],
              ),
              _PerformanceCard(
                title: 'Best Streak',
                value: '21',
                icon: Icons.local_fire_department_rounded,
                color: Colors.orangeAccent,
                data: [0.2, 0.3, 0.5, 0.4, 0.7, 1.0],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  const _PerformanceCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.data,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final List<double> data;

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(12.w),
      borderRadius: 20,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 20.h,
            width: 60.w,
            child: CustomPaint(
              painter: _SparklinePainter(data: data, color: color),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18.sp),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: context.titleLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    title,
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontWeight: FontWeight.bold,
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

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.data, required this.color});
  final List<double> data;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (var i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height * (1.0 - data[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Glow effect
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
