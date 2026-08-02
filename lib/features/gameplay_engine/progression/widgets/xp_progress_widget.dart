import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

class XPProgressWidget extends ConsumerWidget {
  const XPProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(levelProgressProvider);
    final level = ref.watch(levelProvider);
    final levelEngine = ref.watch(levelEngineProvider);

    final xpRequired = levelEngine.config.xpRequiredBetweenLevels(level);
    final snapshot = ref.watch(progressionProvider);
    final xpInCurrent =
        snapshot.totalXP - levelEngine.config.xpRequiredForLevel(level);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LEVEL $level',
              style: SoteriaTypography.label.copyWith(
                color: SoteriaColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$xpInCurrent / $xpRequired XP',
              style: SoteriaTypography.label.copyWith(
                color: SoteriaColors.textPrimary.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: SoteriaColors.textPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedContainer(
                  duration: SoteriaAnimations.normal,
                  curve: Curves.easeOutCubic,
                  height: 8,
                  width: constraints.maxWidth * progress,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [SoteriaColors.primary, SoteriaColors.secondary],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: SoteriaColors.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
