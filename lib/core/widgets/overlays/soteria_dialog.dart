import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';

/// A premium modal dialog for critical user interactions.
///
/// Features an optional icon, title, message, and customizable actions.
import '../../utils/soteria_responsive.dart';

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
      barrierColor: Colors.black.withValues(alpha: 0.8),
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
    final isShort = SoteriaResponsive.isShortScreen(context);

    return Dialog(
      backgroundColor: SoteriaColors.elevatedSurface,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.adaptive(context, SoteriaSpacing.xlStatic),
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(borderRadius: SoteriaRadius.brLg),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: EdgeInsets.all(
            SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: isShort ? 32 : 48,
                  color: iconColor ?? SoteriaColors.primary,
                ),
                SizedBox(
                  height: SoteriaSpacing.adaptive(
                    context,
                    SoteriaSpacing.mdStatic,
                  ),
                ),
              ],
              Text(
                title,
                style: (isShort ? context.titleMedium : context.titleLarge)
                    .copyWith(fontWeight: FontWeight.w900, letterSpacing: 0.5),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SoteriaSpacing.adaptive(
                  context,
                  SoteriaSpacing.smStatic,
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    message,
                    style: (isShort ? context.bodyMedium : context.bodyLarge)
                        .copyWith(color: SoteriaColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: SoteriaSpacing.adaptive(
                  context,
                  SoteriaSpacing.lgStatic,
                ),
              ),
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
      ),
    );
  }
}
