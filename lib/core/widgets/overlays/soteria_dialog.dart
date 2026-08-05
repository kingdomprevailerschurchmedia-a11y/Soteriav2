import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';

/// A premium modal dialog for critical user interactions.
///
/// Features an optional icon, title, message, and customizable actions.
class SoteriaDialog extends StatelessWidget {
  const SoteriaDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
    this.icon,
    this.iconColor,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;
  final IconData? icon;
  final Color? iconColor;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => SoteriaDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
        icon: icon,
        iconColor: iconColor,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: SoteriaColors.elevatedSurface,
      shape: RoundedRectangleBorder(borderRadius: SoteriaRadius.brLg),
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 48, color: iconColor ?? SoteriaColors.primary),
              SizedBox(height: SoteriaSpacing.md),
            ],
            Text(title, style: context.titleLarge, textAlign: TextAlign.center),
            SizedBox(height: SoteriaSpacing.sm),
            Text(
              message,
              style: context.bodyLarge.copyWith(
                color: SoteriaColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: SoteriaButton.ghost(
                    label: cancelLabel,
                    onPressed: onCancel ?? () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(width: SoteriaSpacing.md),
                Expanded(
                  child: SoteriaButton.primary(
                    label: confirmLabel,
                    onPressed: onConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
