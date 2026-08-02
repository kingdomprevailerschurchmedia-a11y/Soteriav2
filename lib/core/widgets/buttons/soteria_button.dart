import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

enum SoteriaButtonVariant { primary, secondary, ghost, text }

/// A premium button component following the Soteria Design Language.
///
/// Supports multiple variants: [primary], [secondary], [ghost], and [text].
/// Can display an optional icon and a loading state.
class SoteriaButton extends StatelessWidget {
  const SoteriaButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
  }) : variant = SoteriaButtonVariant.primary;

  const SoteriaButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
  }) : variant = SoteriaButtonVariant.secondary;

  const SoteriaButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
  }) : variant = SoteriaButtonVariant.ghost;

  const SoteriaButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
  }) : variant = SoteriaButtonVariant.text;

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final SoteriaButtonVariant variant;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    Widget buttonContent = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 18.0.w,
            height: 18.0.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        else ...[
          if (icon != null) ...[
            Icon(icon, size: 18.0.w),
            SizedBox(width: SoteriaSpacing.sm),
          ],
          Flexible(
            child: Text(
              label,
              style: context.labelLarge.copyWith(
                color: _getTextColor(isDisabled),
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ],
    );

    if (fullWidth) {
      buttonContent = SizedBox(width: double.infinity, child: buttonContent);
    }

    return AnimatedOpacity(
      duration: SoteriaAnimations.fast,
      opacity: isDisabled ? 0.5 : 1.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: SoteriaRadius.brMd,
          child: Ink(
            padding: EdgeInsets.symmetric(
              vertical: SoteriaSpacing.md,
              horizontal: SoteriaSpacing
                  .md, // Reduced from .lg for better responsiveness
            ),
            decoration: BoxDecoration(
              color: _getBackgroundColor(isDisabled),
              gradient: _getGradient(isDisabled),
              borderRadius: SoteriaRadius.brMd,
              border: _getBorder(isDisabled),
            ),
            child: buttonContent,
          ),
        ),
      ),
    );
  }

  Color? _getBackgroundColor(bool isDisabled) {
    if (variant == SoteriaButtonVariant.secondary) return SoteriaColors.surface;
    if (variant == SoteriaButtonVariant.ghost) return Colors.transparent;
    if (variant == SoteriaButtonVariant.text) return Colors.transparent;
    return null; // Primary uses gradient
  }

  Gradient? _getGradient(bool isDisabled) {
    if (variant == SoteriaButtonVariant.primary) {
      return const LinearGradient(
        colors: [SoteriaColors.primary, SoteriaColors.secondary],
      );
    }
    return null;
  }

  Border? _getBorder(bool isDisabled) {
    if (variant == SoteriaButtonVariant.ghost) {
      return Border.all(color: SoteriaColors.border);
    }
    return null;
  }

  Color _getTextColor(bool isDisabled) {
    if (variant == SoteriaButtonVariant.text) return SoteriaColors.primary;
    if (variant == SoteriaButtonVariant.secondary)
      return SoteriaColors.textPrimary;
    return Colors.white;
  }
}
