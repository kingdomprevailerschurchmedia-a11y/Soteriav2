import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/gradients/soteria_gradients.dart';
import '../../../../core/navigation/providers/navigation_providers.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';

class QuickActionsGrid extends ConsumerWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.watch(navigationCoordinatorProvider);

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
            children: [
              _ActionCard(
                title: 'Practice',
                subtitle: 'Level Up',
                icon: Icons.school_rounded,
                gradient: SoteriaGradients.competition,
                delay: 100,
                onTap: nav.playPractice,
              ),
              _ActionCard(
                title: 'Pro Mode',
                subtitle: 'Win Coins',
                icon: Icons.stars_rounded,
                gradient: SoteriaGradients.reward,
                delay: 200,
                onTap: nav.playProMode,
              ),
              _ActionCard(
                title: 'Versus',
                subtitle: '1v1 Match',
                icon: Icons.bolt_rounded,
                gradient: SoteriaGradients.competition,
                delay: 300,
                onTap: nav.playVersus,
              ),
              _ActionCard(
                title: 'Tournament',
                subtitle: 'Compete',
                icon: Icons.emoji_events_rounded,
                gradient: SoteriaGradients.reward,
                delay: 400,
                onTap: nav.playTournament,
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
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final int delay;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SoteriaFadeIn(
      delay: Duration(milliseconds: delay),
      child: SoteriaScaleIn(
        delay: Duration(milliseconds: delay),
        begin: 0.9,
        child: GestureDetector(
          onTap: onTap,
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
      ),
    );
  }
}
