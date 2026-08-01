import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';

class SoteriaEmptyState extends StatelessWidget {
  const SoteriaEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.actionLabel,
    this.onActionPressed,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SoteriaSpacing.lg), // Reduced from xxl for better small-container fit
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 64, // Slightly reduced from 80 for better scaling
                color: SoteriaColors.muted.withValues(alpha: 0.3),
              ),
              SizedBox(height: SoteriaSpacing.lg), // Reduced from xl
              Text(
                title,
                style: context.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SoteriaSpacing.xs), // Reduced from sm
              Text(
                subtitle,
                style: context.bodyLarge.copyWith(color: SoteriaColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              if (actionLabel != null && onActionPressed != null) ...[
                SizedBox(height: SoteriaSpacing.lg), // Reduced from xl
                SoteriaButton.primary(
                  label: actionLabel!,
                  onPressed: onActionPressed!,
                  fullWidth: false,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
