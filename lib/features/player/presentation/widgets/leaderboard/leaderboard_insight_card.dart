import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';
import 'package:soteria/features/player/domain/services/leaderboard_insights_service.dart';

class LeaderboardInsightCard extends StatelessWidget {
  final LeaderboardInsight insight;

  const LeaderboardInsightCard({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderColor: insight.isPositive 
          ? SoteriaColors.success.withValues(alpha: 0.2) 
          : SoteriaColors.error.withValues(alpha: 0.2),
      child: Row(
        children: [
          Icon(
            insight.isPositive ? Icons.trending_up_rounded : Icons.info_outline_rounded,
            color: insight.isPositive ? SoteriaColors.success : SoteriaColors.error,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SoteriaText.body(
                  insight.title,
                  color: Colors.white,
                ),
                SoteriaText.caption(
                  insight.description,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
