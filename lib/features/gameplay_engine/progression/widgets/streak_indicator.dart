import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/progression/providers/progression_providers.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class StreakIndicator extends ConsumerWidget {
  const StreakIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);
    final isActive = streak > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? SoteriaColors.error.withValues(alpha: 0.1)
            : SoteriaColors.textPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? SoteriaColors.error.withValues(alpha: 0.5)
              : SoteriaColors.textPrimary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            size: 18,
            color: isActive
                ? SoteriaColors.error
                : SoteriaColors.textPrimary.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 6),
          Text(
            streak.toString(),
            style: SoteriaTypography.body.copyWith(
              color: isActive
                  ? SoteriaColors.textPrimary
                  : SoteriaColors.textPrimary.withValues(alpha: 0.3),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
