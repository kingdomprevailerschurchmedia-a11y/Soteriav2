import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/performance_insight.dart';
import '../../domain/models/analytics_enums.dart';

class InsightCard extends StatelessWidget {
  final PerformanceInsight insight;

  const InsightCard({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SoteriaColors.primary.withValues(alpha: 0.15),
            SoteriaColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTypeIcon(),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight.title,
                      style: SoteriaTypography.titleSmall.copyWith(
                        color: SoteriaColors.textPrimary,
                      ),
                    ),
                    Text(
                      insight.type.name.toUpperCase(),
                      style: SoteriaTypography.labelSmall.copyWith(
                        color: SoteriaColors.primary.withValues(alpha: 0.8),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    insight.metricValue,
                    style: SoteriaTypography.titleMedium.copyWith(
                      color: SoteriaColors.textPrimary,
                    ),
                  ),
                  Text(
                    insight.metricLabel,
                    style: SoteriaTypography.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            insight.description,
            style: SoteriaTypography.bodyMedium.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
          if (insight.recommendation != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: SoteriaColors.background.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 14.w,
                    color: SoteriaColors.gold,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      insight.recommendation!,
                      style: SoteriaTypography.labelSmall.copyWith(
                        color: SoteriaColors.gold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypeIcon() {
    IconData icon;
    Color color;

    switch (insight.type) {
      case InsightType.improvement:
        icon = Icons.trending_up;
        color = SoteriaColors.success;
        break;
      case InsightType.strength:
        icon = Icons.verified;
        color = SoteriaColors.gold;
        break;
      case InsightType.opportunity:
        icon = Icons.auto_graph;
        color = SoteriaColors.info;
        break;
      case InsightType.speed:
        icon = Icons.speed;
        color = SoteriaColors.xpColor;
        break;
      case InsightType.accuracy:
        icon = Icons.gps_fixed;
        color = SoteriaColors.primary;
        break;
      case InsightType.consistency:
        icon = Icons.balance;
        color = SoteriaColors.secondary;
        break;
      case InsightType.personalBest:
        icon = Icons.emoji_events;
        color = SoteriaColors.gold;
        break;
      default:
        icon = Icons.analytics_outlined;
        color = SoteriaColors.muted;
    }

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20.w),
    );
  }
}
