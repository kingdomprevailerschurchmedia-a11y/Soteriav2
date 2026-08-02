import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/widgets/animations/soteria_animations.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.level,
    required this.xp,
    required this.totalXpRequired,
    required this.coins,
    required this.rank,
  });

  final int level;
  final int xp;
  final int totalXpRequired;
  final int coins;
  final String rank;

  @override
  Widget build(BuildContext context) {
    final progress = (xp / totalXpRequired).clamp(0.0, 1.0);

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
              SizedBox(height: SoteriaSpacing.xl),
              Row(
                children: [
                  _ProgressRing(progress: progress, level: level),
                  SizedBox(width: SoteriaSpacing.xl),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You are ${totalXpRequired - xp} XP away from Level ${level + 1}',
                          style: context.bodyMedium.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: SoteriaSpacing.sm),
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          valueColor: const AlwaysStoppedAnimation(
                            SoteriaColors.primary,
                          ),
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        SizedBox(height: SoteriaSpacing.xs),
                        Text(
                          '$xp / $totalXpRequired XP',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.muted,
                          ),
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
          Text(
            coins.toString(),
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing({required this.progress, required this.level});
  final double progress;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 8,
            backgroundColor: Colors.white.withValues(alpha: 0.05),
            valueColor: const AlwaysStoppedAnimation(SoteriaColors.primary),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Lvl',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                fontSize: 10,
              ),
            ),
            Text(
              level.toString(),
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ],
    );
  }
}
