import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({
    super.key,
    required this.questionsAnswered,
    required this.accuracy,
    required this.gamesPlayed,
    required this.highestStreak,
  });

  final int questionsAnswered;
  final double accuracy;
  final int gamesPlayed;
  final int highestStreak;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PERFORMANCE',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.2,
            children: [
              _StatItem(
                label: 'Answered',
                value: questionsAnswered.toString(),
                icon: Icons.quiz_rounded,
                color: SoteriaColors.primary,
              ),
              _StatItem(
                label: 'Accuracy',
                value: '${(accuracy * 100).toInt()}%',
                icon: Icons.track_changes_rounded,
                color: SoteriaColors.success,
              ),
              _StatItem(
                label: 'Matches',
                value: gamesPlayed.toString(),
                icon: Icons.videogame_asset_rounded,
                color: SoteriaColors.secondary,
              ),
              _StatItem(
                label: 'Best Streak',
                value: highestStreak.toString(),
                icon: Icons.local_fire_department_rounded,
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
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
    return GlassSurface(
      padding: EdgeInsets.all(SoteriaSpacing.sm),
      opacity: 0.04,
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: SoteriaSpacing.sm),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
