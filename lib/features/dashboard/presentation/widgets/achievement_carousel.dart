import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';

class AchievementCarousel extends StatelessWidget {
  const AchievementCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
          child: Text(
            'RECENT ACHIEVEMENTS',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
            children: const [
              _AchievementCard(
                title: 'First Win',
                icon: Icons.workspace_premium_rounded,
                isUnlocked: true,
              ),
              _AchievementCard(
                title: 'Logic Master',
                icon: Icons.psychology_rounded,
                isUnlocked: true,
              ),
              _AchievementCard(
                title: 'Century',
                icon: Icons.history_edu_rounded,
                isUnlocked: false,
              ),
              _AchievementCard(
                title: 'Streak 7',
                icon: Icons.local_fire_department_rounded,
                isUnlocked: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({
    required this.title,
    required this.icon,
    required this.isUnlocked,
  });

  final String title;
  final IconData icon;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: SoteriaSpacing.md),
      child: GlassSurface(
        borderRadius: BorderRadius.circular(20),
        opacity: isUnlocked ? 0.08 : 0.03,
        child: Padding(
          padding: EdgeInsets.all(SoteriaSpacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isUnlocked
                    ? SoteriaColors.gold
                    : SoteriaColors.muted.withValues(alpha: 0.3),
                size: 32,
              ),
              SizedBox(height: SoteriaSpacing.sm),
              Text(
                title,
                style: context.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? Colors.white : SoteriaColors.muted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
