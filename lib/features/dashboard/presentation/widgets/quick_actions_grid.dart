import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/gradients/soteria_gradients.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/widgets/animations/soteria_animations.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUICK ACTIONS',
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
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.4,
            children: const [
              _ActionCard(
                title: 'Practice',
                subtitle: 'Level Up',
                icon: Icons.school_rounded,
                gradient: SoteriaGradients.competition,
                delay: 100,
              ),
              _ActionCard(
                title: 'Pro Mode',
                subtitle: 'Win Coins',
                icon: Icons.stars_rounded,
                gradient: SoteriaGradients.reward,
                delay: 200,
              ),
              _ActionCard(
                title: 'Versus',
                subtitle: '1v1 Match',
                icon: Icons.bolt_rounded,
                gradient: SoteriaGradients.competition,
                delay: 300,
              ),
              _ActionCard(
                title: 'Tournament',
                subtitle: 'Compete',
                icon: Icons.emoji_events_rounded,
                gradient: SoteriaGradients.reward,
                delay: 400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.delay,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return SoteriaFadeIn(
      delay: Duration(milliseconds: delay),
      child: SoteriaScaleIn(
        delay: Duration(milliseconds: delay),
        begin: 0.9,
        child: GlassSurface(
          borderRadius: BorderRadius.circular(24),
          opacity: 0.05,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  gradient.colors.first.withValues(alpha: 0.1),
                  gradient.colors.last.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(SoteriaSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: gradient.colors.first, size: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.muted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
