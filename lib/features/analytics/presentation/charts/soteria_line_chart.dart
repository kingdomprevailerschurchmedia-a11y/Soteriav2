import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/performance_trend.dart';

class SoteriaLineChart extends StatelessWidget {
  final PerformanceTrend trend;
  final Color? color;
  final bool showDots;
  final bool animate;

  const SoteriaLineChart({
    super.key,
    required this.trend,
    this.color,
    this.showDots = true,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    if (trend.points.isEmpty) {
      return const SizedBox.shrink();
    }

    final lineColor = color ?? SoteriaColors.primary;

    return LineChart(
      duration: animate ? const Duration(milliseconds: 800) : Duration.zero,
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: (trend.maxValue - trend.minValue) / 4,
          getDrawingHorizontalLine: (value) => FlLine(
            color: SoteriaColors.border.withOpacity(0.05),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32.w,
              interval: (trend.maxValue - trend.minValue) / 2,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: SoteriaTypography.bodySmall.copyWith(
                    color: SoteriaColors.muted.withOpacity(0.5),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (trend.points.length - 1).toDouble(),
        minY: trend.minValue * 0.9,
        maxY: trend.maxValue * 1.1,
        lineBarsData: [
          LineChartBarData(
            spots: trend.points.asMap().entries.map((e) {
              return FlSpot(e.key.toDouble(), e.value.value);
            }).toList(),
            isCurved: true,
            color: lineColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: showDots,
              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                radius: 4,
                color: lineColor,
                strokeWidth: 2,
                strokeColor: SoteriaColors.background,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  lineColor.withOpacity(0.2),
                  lineColor.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => SoteriaColors.surface,
            // tooltipRoundedRadius was removed in fl_chart 1.x
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  flSpot.y.toStringAsFixed(1),
                  SoteriaTypography.labelLarge.copyWith(color: SoteriaColors.textPrimary),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
