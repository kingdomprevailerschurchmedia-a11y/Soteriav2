import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/analytics_enums.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subValue;
  final IconData? icon;
  final Color? color;
  final TrendDirection? direction;
  final String? trendLabel;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subValue,
    this.icon,
    this.color,
    this.direction,
    this.trendLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16.w, color: color ?? SoteriaColors.primary),
                SizedBox(width: 8.w),
              ],
              Expanded(
                child: Text(
                  title,
                  style: SoteriaTypography.labelMedium.copyWith(color: SoteriaColors.muted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: SoteriaTypography.headlineSmall.copyWith(color: SoteriaColors.textPrimary),
          ),
          if (subValue != null) ...[
            SizedBox(height: 4.h),
            Text(
              subValue!,
              style: SoteriaTypography.bodySmall.copyWith(color: SoteriaColors.muted),
            ),
          ],
          if (direction != null && direction != TrendDirection.insufficientData) ...[
            SizedBox(height: 8.h),
            _TrendIndicator(direction: direction!, label: trendLabel),
          ],
        ],
      ),
    );
  }
}

class _TrendIndicator extends StatelessWidget {
  final TrendDirection direction;
  final String? label;

  const _TrendIndicator({required this.direction, this.label});

  @override
  Widget build(BuildContext context) {
    final isPositive = direction == TrendDirection.improving;
    final color = isPositive ? SoteriaColors.success : SoteriaColors.error;
    final icon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Row(
      children: [
        Icon(icon, size: 14.w, color: color),
        SizedBox(width: 4.w),
        Text(
          label ?? (isPositive ? 'Improving' : 'Declining'),
          style: SoteriaTypography.labelSmall.copyWith(color: color),
        ),
      ],
    );
  }
}
