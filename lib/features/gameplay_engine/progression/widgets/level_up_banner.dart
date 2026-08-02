import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class LevelUpBanner extends StatelessWidget {
  final int newLevel;
  final VoidCallback onDismiss;

  const LevelUpBanner({
    super.key,
    required this.newLevel,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SoteriaColors.primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.primary.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'LEVEL UP!',
            style: SoteriaTypography.headline.copyWith(
              color: SoteriaColors.primary,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You reached Level $newLevel',
            style: SoteriaTypography.body.copyWith(
              color: SoteriaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onDismiss,
            style: ElevatedButton.styleFrom(
              backgroundColor: SoteriaColors.primary,
              foregroundColor: SoteriaColors.textPrimary,
            ),
            child: const Text('AWESOME'),
          ),
        ],
      ),
    );
  }
}
