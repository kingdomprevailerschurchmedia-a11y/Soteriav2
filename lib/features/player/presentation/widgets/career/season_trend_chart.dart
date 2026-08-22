import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../domain/models/season_result.dart';

class SeasonTrendChart extends StatelessWidget {
  final List<SeasonResult> results;
  final Color? color;
  final bool animate;

  const SeasonTrendChart({
    super.key,
    required this.results,
    this.color,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    if (results.length < 2) {
      return const SizedBox.shrink();
    }

    final sortedResults = List<SeasonResult>.from(results)
      ..sort((a, b) => a.seasonNumber.compareTo(b.seasonNumber));

    final spots = sortedResults.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.finalRankPoints.toDouble());
    }).toList();

    final maxRP = sortedResults.map((e) => e.finalRankPoints).reduce((a, b) => a > b ? a : b);
    final minRP = sortedResults.map((e) => e.finalRankPoints).reduce((a, b) => a < b ? a : b);

    final lineColor = color ?? SoteriaColors.primary;

    return LineChart(
      duration: animate ? const Duration(milliseconds: 800) : Duration.zero,
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: (maxRP - minRP) > 0 ? (maxRP - minRP) / 4 : 100,
          getDrawingHorizontalLine: (value) => FlLine(
            color: SoteriaColors.border.withValues(alpha: 0.05),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32.h,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= sortedResults.length) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    'S${sortedResults[index].seasonNumber}',
                    style: SoteriaTypography.bodySmall.copyWith(
                      color: SoteriaColors.muted.withValues(alpha: 0.5),
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40.w,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: SoteriaTypography.bodySmall.copyWith(
                    color: SoteriaColors.muted.withValues(alpha: 0.5),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (sortedResults.length - 1).toDouble(),
        minY: minRP * 0.8,
        maxY: maxRP * 1.2,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: lineColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
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
                  lineColor.withValues(alpha: 0.2),
                  lineColor.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => SoteriaColors.surface,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                return LineTooltipItem(
                  '${barSpot.y.toInt()} RP',
                  SoteriaTypography.labelLarge.copyWith(
                    color: SoteriaColors.textPrimary,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
