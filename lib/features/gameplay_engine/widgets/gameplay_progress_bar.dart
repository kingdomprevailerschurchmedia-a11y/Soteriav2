import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';

class GameplayProgressBar extends StatelessWidget {
  final double progress;
  final int current;
  final int total;

  const GameplayProgressBar({
    super.key,
    required this.progress,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Progress: $current of $total questions completed',
      value: '${(progress * 100).toInt()}%',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question $current of $total'.toUpperCase(),
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.sm),
          SoteriaProgressBar(progress: progress, height: 6, hasGlow: true),
        ],
      ),
    );
  }
}
