import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';

class SoteriaBarChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final Color? color;

  const SoteriaBarChart({
    super.key,
    required this.data,
    required this.labels,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final barColor = color ?? SoteriaColors.primary;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < labels.length) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      labels[value.toInt()],
                      style: SoteriaTypography.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 28.h,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: data.asMap().entries.map((e) {
          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value,
                color: barColor,
                width: 16.w,
                borderRadius: BorderRadius.circular(4.r),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 100,
                  color: SoteriaColors.border.withOpacity(0.05),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
