import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class SoteriaChip extends StatelessWidget {
  const SoteriaChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.md,
          vertical: SoteriaSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? SoteriaColors.primary : SoteriaColors.surface,
          borderRadius: SoteriaRadius.brFull,
          border: Border.all(
            color: isSelected ? SoteriaColors.primary : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : SoteriaColors.muted,
              ),
              SizedBox(width: SoteriaSpacing.sm),
            ],
            Text(
              label,
              style: context.labelLarge.copyWith(
                color: isSelected ? Colors.white : SoteriaColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
