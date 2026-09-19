import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/competitive_career_summary.dart';

class CareerStatisticsSection extends StatelessWidget {
  final CompetitiveCareerSummary summary;

  const CareerStatisticsSection({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.bar_chart_rounded, color: SoteriaColors.gold, size: 20.r),
                SizedBox(width: 12.w),
                Text(
                  'Career Statistics',
                  style: context.titleSmall.copyWith(
                    color: SoteriaColors.gold,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
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
                      color: SoteriaColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.chevron_right_rounded, color: SoteriaColors.gold, size: 18.r),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 10.w,
          crossAxisSpacing: 10.w,
          childAspectRatio: 0.75,
          children: [
            _CompactStatBox(
              label: 'Total Matches',
              value: '${summary.totalMatches}',
              icon: Icons.sports_esports_rounded,
              color: const Color(0xFF7C4DFF),
            ),
            _CompactStatBox(
              label: 'Win Rate',
              value: '${(summary.winRate * 100).toStringAsFixed(1)}%',
              icon: Icons.trending_up_rounded,
              color: const Color(0xFF4CAF50),
            ),
            _CompactStatBox(
              label: 'Total Wins',
              value: '${summary.totalWins}',
              icon: Icons.emoji_events_rounded,
              color: const Color(0xFFFFD700),
            ),
            _CompactStatBox(
              label: 'Best Rank',
              value: summary.bestRank == 'Unranked' ? 'N/A' : summary.bestRank,
              icon: Icons.workspace_premium_rounded,
              color: const Color(0xFFB456FF),
            ),
          ],
        ),
      ],
    );
  }
}

class _CompactStatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _CompactStatBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20.r),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: context.titleMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
