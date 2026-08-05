import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import '../models/game_result.dart';

class PerformanceInsightCard extends StatelessWidget {
  final GameResult result;

  const PerformanceInsightCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final insight = _generateInsight();

    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PERFORMANCE INSIGHT',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(insight.icon, color: insight.color, size: 32),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight.title,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SoteriaSpacing.xs),
                    Text(
                      insight.description,
                      style: context.bodyMedium.copyWith(
                        color: SoteriaColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _Insight _generateInsight() {
    if (result.accuracy >= 1.0) {
      return const _Insight(
        title: 'Legendary Precision',
        description:
            'You maintained absolute accuracy throughout the session. Consider increasing difficulty.',
        icon: Icons.workspace_premium_rounded,
        color: SoteriaColors.gold,
      );
    } else if (result.accuracy >= 0.8) {
      return const _Insight(
        title: 'Competitive Edge',
        description:
            'Strong performance. Minor slips prevented a perfect score, but your pace is excellent.',
        icon: Icons.trending_up_rounded,
        color: SoteriaColors.success,
      );
    } else if (result.avgResponseTime.inSeconds < 3 && result.accuracy < 0.6) {
      return const _Insight(
        title: 'Haste Makes Waste',
        description:
            'You are answering very quickly, but accuracy is suffering. Slow down to improve retention.',
        icon: Icons.speed_rounded,
        color: SoteriaColors.warning,
      );
    } else {
      return const _Insight(
        title: 'Foundational Growth',
        description:
            'Consistency is key. Focus on categorizing your weak areas for targeted practice.',
        icon: Icons.psychology_rounded,
        color: SoteriaColors.primary,
      );
    }
  }
}

class _Insight {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _Insight({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
