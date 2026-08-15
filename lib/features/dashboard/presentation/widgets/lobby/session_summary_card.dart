import 'package:flutter/material.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/widgets/glass_surface.dart';
import '../../../../gameplay_engine/services/reward_estimator.dart';

class SessionSummaryCard extends StatelessWidget {
  const SessionSummaryCard({super.key, required this.rewards});
  final EstimatedRewards rewards;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.gold.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: -8,
          ),
        ],
      ),
      child: GlassSurface(
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.lg,
          vertical: SoteriaSpacing.md,
        ),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'SESSION SUMMARY',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w900,
                    fontSize: 9,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.auto_graph_rounded,
                  color: SoteriaColors.gold.withValues(alpha: 0.5),
                  size: 12,
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryItem(
                  label: 'XP',
                  value: '+${rewards.xp}',
                  icon: Icons.bolt_rounded,
                  color: SoteriaColors.xpColor,
                ),
                _SummaryItem(
                  label: 'Coins',
                  value: '+${rewards.coins}',
                  icon: Icons.monetization_on_rounded,
                  color: SoteriaColors.gold,
                ),
                _SummaryItem(
                  label: 'Time',
                  value: '${rewards.estimatedDuration.inMinutes}m',
                  icon: Icons.timer_rounded,
                  color: Colors.white70,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(height: 4),
        Text(
          value,
          style: context.bodyMedium.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
