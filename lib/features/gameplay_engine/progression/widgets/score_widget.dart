import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class ScoreWidget extends ConsumerWidget {
  final bool useSessionScore;

  const ScoreWidget({super.key, this.useSessionScore = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = useSessionScore
        ? ref.watch(progressionProvider.select((s) => s.sessionScore))
        : ref.watch(scoreProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'SCORE',
          style: SoteriaTypography.label.copyWith(
            color: SoteriaColors.textPrimary.withValues(alpha: 0.6),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            score.toString().padLeft(6, '0'),
            key: ValueKey(score),
            style: SoteriaTypography.headline.copyWith(
              color: SoteriaColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
