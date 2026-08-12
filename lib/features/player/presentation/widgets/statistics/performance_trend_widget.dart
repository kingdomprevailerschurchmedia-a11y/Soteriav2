import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';

class PerformanceTrendWidget extends StatelessWidget {
  final PerformanceTrend trend;

  const PerformanceTrendWidget({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    final icon = _getStatusIcon();

    return Semantics(
      label: '${trend.metricName} trend: ${_getStatusText()}',
      value:
          '${trend.changePercentage >= 0 ? 'Increased' : 'Decreased'} ${(trend.changePercentage * 100).abs().toStringAsFixed(1)} percent',
      child: SoteriaCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trend.metricName.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    letterSpacing: 1.2,
                  ),
                ),
                _buildTrendBadge(color, icon),
              ],
            ),
            SizedBox(height: SoteriaSpacing.xs),
            Text(
              '${trend.changePercentage >= 0 ? '+' : ''}${(trend.changePercentage * 100).toStringAsFixed(1)}%',
              style: context.headlineSmall.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (trend.dataPoints.isNotEmpty) ...[
              SizedBox(height: SoteriaSpacing.md),
              _buildSparkline(context, color),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTrendBadge(Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            _getStatusText(),
            style: TextStyle(
              color: color,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSparkline(BuildContext context, Color color) {
    return SizedBox(
      height: 40.h,
      child: CustomPaint(
        painter: _SparklinePainter(trend.dataPoints, color),
        child: Container(),
      ),
    );
  }

  Color _getStatusColor() {
    switch (trend.state) {
      case TrendState.improving:
        return SoteriaColors.success;
      case TrendState.declining:
        return SoteriaColors.error;
      case TrendState.stable:
        return SoteriaColors.muted;
      case TrendState.insufficientData:
        return SoteriaColors.muted.withValues(alpha: 0.5);
    }
  }

  IconData _getStatusIcon() {
    switch (trend.state) {
      case TrendState.improving:
        return Icons.trending_up_rounded;
      case TrendState.declining:
        return Icons.trending_down_rounded;
      default:
        return Icons.trending_flat_rounded;
    }
  }

  String _getStatusText() {
    switch (trend.state) {
      case TrendState.improving:
        return 'IMPROVING';
      case TrendState.declining:
        return 'DECLINING';
      case TrendState.stable:
        return 'STABLE';
      case TrendState.insufficientData:
        return 'NEW';
    }
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _SparklinePainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final stepX = size.width / (data.length - 1);
    final minVal = data.reduce((a, b) => a < b ? a : b);
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    final range = (maxVal - minVal).clamp(0.001, double.infinity);

    for (var i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - ((data[i] - minVal) / range * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Gradient fill
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, gradientPaint);
  }

  @override
  bool shouldRepaint(_SparklinePainter oldDelegate) => data != oldDelegate.data;
}
