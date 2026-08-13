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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/performance_icon.png',
                    width: 28.w,
                    height: 28.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'PERFORMANCE',
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
          SizedBox(height: 16.h),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 2.3,
            children: [
              _PerformanceCard(
                title: 'Answered',
                value: '1,250',
                icon: Icons.quiz_rounded,
                color: const Color(0xFF9155FD),
                data: [0.2, 0.4, 0.3, 0.7, 0.5, 0.8, 0.6, 0.9],
              ),
              _PerformanceCard(
                title: 'Accuracy',
                value: '85%',
                icon: Icons.track_changes_rounded,
                color: const Color(0xFF4CAF50),
                data: [0.6, 0.5, 0.8, 0.7, 0.9, 0.85, 0.95, 0.8],
              ),
              _PerformanceCard(
                title: 'Matches',
                value: '142',
                icon: Icons.sports_esports_rounded,
                color: const Color(0xFF2196F3),
                data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.6, 0.5, 0.7],
              ),
              _PerformanceCard(
                title: 'Best Streak',
                value: '21',
                icon: Icons.local_fire_department_rounded,
                color: const Color(0xFFFF9F43),
                data: [0.2, 0.3, 0.5, 0.4, 0.7, 0.8, 0.6, 1.0],
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      borderRadius: 18.r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Glowing Icon
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.15),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                color: color,
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Value & Label
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: context.titleLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 16.sp,
                      height: 1.0,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  title,
                  style: context.labelSmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w600,
                    fontSize: 9.sp,
                    letterSpacing: 0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          // Sparkline
          SizedBox(
            width: 38.w,
            height: 18.h,
            child: CustomPaint(
              painter: _SparklinePainter(data: data, color: color),
            ),
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
      ..strokeWidth = 1.5
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

    // Fill gradient
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.25),
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Glow line
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
