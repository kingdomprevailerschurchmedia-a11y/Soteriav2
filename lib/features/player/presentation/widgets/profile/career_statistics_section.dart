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
        Text(
          'CAREER STATISTICS',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: SoteriaSpacing.md,
          crossAxisSpacing: SoteriaSpacing.md,
          childAspectRatio: 2.0,
          children: [
            _StatCard(
              label: 'TOTAL MATCHES',
              value: '${summary.totalMatches}',
              icon: Icons.sports_esports_rounded,
              color: SoteriaColors.primary,
            ),
            _StatCard(
              label: 'WIN RATE',
              value: '${(summary.winRate * 100).toStringAsFixed(1)}%',
              icon: Icons.trending_up_rounded,
              color: SoteriaColors.success,
            ),
            _StatCard(
              label: 'TOTAL WINS',
              value: '${summary.totalWins}',
              icon: Icons.emoji_events_rounded,
              color: SoteriaColors.gold,
            ),
            _StatCard(
              label: 'BEST RANK',
              value: summary.bestRank,
              icon: Icons.workspace_premium_rounded,
              color: SoteriaColors.secondary,
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(SoteriaSpacing.xs),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16.sp),
          ),
          SizedBox(width: SoteriaSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontSize: 8.sp,
                  ),
                ),
                Text(
                  value,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
