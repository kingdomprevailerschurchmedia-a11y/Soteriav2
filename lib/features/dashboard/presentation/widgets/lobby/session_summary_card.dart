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
    return GlassSurface(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SESSION SUMMARY',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(
                label: 'Potential XP',
                value: '+${rewards.xp}',
                icon: Icons.bolt_rounded,
                color: SoteriaColors.primary,
              ),
              _SummaryItem(
                label: 'Potential Coins',
                value: '+${rewards.coins}',
                icon: Icons.monetization_on_rounded,
                color: SoteriaColors.gold,
              ),
              _SummaryItem(
                label: 'Est. Time',
                value: '${rewards.estimatedDuration.inMinutes}m',
                icon: Icons.timer_rounded,
                color: Colors.white70,
              ),
            ],
          ),
        ],
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
        Icon(icon, color: color, size: 24),
        SizedBox(height: SoteriaSpacing.xs),
        Text(
          value,
          style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 8,
          ),
        ),
      ],
    );
  }
}
