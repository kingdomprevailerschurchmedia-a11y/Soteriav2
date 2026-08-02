import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/gradients/soteria_gradients.dart';
import '../../../../core/widgets/animations/soteria_animations.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    required this.greeting,
    required this.playerName,
    required this.level,
    required this.streak,
    this.avatarUrl,
  });

  final String greeting;
  final String playerName;
  final int level;
  final int streak;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SoteriaSlideLeft(
            duration: const Duration(milliseconds: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  playerName,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xs),
                _HeaderBadge(
                  label: 'LEVEL $level',
                  icon: Icons.auto_awesome_rounded,
                  color: SoteriaColors.primary,
                ),
              ],
            ),
          ),
          SoteriaScaleIn(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
            child: Row(
              children: [
                _StreakCounter(streak: streak),
                SizedBox(width: SoteriaSpacing.md),
                _ProfileAvatar(url: avatarUrl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBadge extends StatelessWidget {
  const _HeaderBadge({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakCounter extends StatelessWidget {
  const _StreakCounter({required this.streak});
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.local_fire_department_rounded,
          color: Colors.orange,
          size: 24,
        ),
        Text(
          streak.toString(),
          style: context.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 2,
        ),
        gradient: SoteriaGradients.competition,
      ),
      child: const Center(
        child: Icon(Icons.person_rounded, color: Colors.white, size: 28),
      ),
    );
  }
}
