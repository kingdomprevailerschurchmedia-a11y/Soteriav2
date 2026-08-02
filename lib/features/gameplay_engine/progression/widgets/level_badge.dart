import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class LevelBadge extends ConsumerWidget {
  final double size;

  const LevelBadge({super.key, this.size = 48});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: SoteriaColors.surface,
        border: Border.all(color: SoteriaColors.secondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.secondary.withValues(alpha: 0.4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          level.toString(),
          style: SoteriaTypography.title.copyWith(
            color: SoteriaColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
