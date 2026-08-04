import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/widgets/animations/soteria_animations.dart';
import '../../../../core/widgets/animations/animated_numeric_counter.dart';
import 'xp_progress_indicator.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.level,
    required this.xpInCurrentLevel,
    required this.xpThreshold,
    required this.coins,
    required this.rank,
    required this.progress,
    required this.xpRemaining,
    this.isDoubleXp = false,
  });

  final int level;
  final int xpInCurrentLevel;
  final int xpThreshold;
  final int coins;
  final String rank;
  final double progress;
  final int xpRemaining;
  final bool isDoubleXp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: SoteriaSlideUp(
        duration: const Duration(milliseconds: 500),
        child: GlassSurface(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          borderRadius: BorderRadius.circular(32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CURRENT RANK',
                        style: context.labelSmall.copyWith(
                          color: SoteriaColors.muted,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        rank.toUpperCase(),
                        style: context.headlineMedium.copyWith(
                          color: SoteriaColors.gold,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  _CoinsDisplay(coins: coins),
                ],
              ),
              if (isDoubleXp) ...[
                SizedBox(height: SoteriaSpacing.md),
                _EventBadge(
                  label: 'DOUBLE XP ACTIVE',
                  icon: Icons.bolt_rounded,
                  color: Colors.cyanAccent,
                ),
              ],
              SizedBox(height: SoteriaSpacing.xl),
              Row(
                children: [
                  XPProgressIndicator(
                    progress: progress,
                    level: level,
                    size: 90,
                    strokeWidth: 10,
                  ),
                  SizedBox(width: SoteriaSpacing.xl),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: context.bodyMedium.copyWith(
                              color: Colors.white70,
                            ),
                            children: [
                              const TextSpan(text: 'Next unlock in '),
                              TextSpan(
                                text: '$xpRemaining XP',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SoteriaSpacing.md),
                        XPProgressBar(progress: progress),
                        SizedBox(height: SoteriaSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedNumericCounter(
                              value: xpInCurrentLevel,
                              suffix: ' XP',
                              style: context.labelSmall.copyWith(
                                color: SoteriaColors.muted,
                              ),
                            ),
                            Text(
                              '$xpThreshold XP',
                              style: context.labelSmall.copyWith(
                                color: SoteriaColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoinsDisplay extends StatelessWidget {
  const _CoinsDisplay({required this.coins});
  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.monetization_on_rounded,
            color: SoteriaColors.gold,
            size: 20,
          ),
          const SizedBox(width: 8),
          AnimatedNumericCounter(
            value: coins,
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _EventBadge extends StatelessWidget {
  const _EventBadge({
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
