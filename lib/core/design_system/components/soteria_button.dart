import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

enum SoteriaButtonVariant { primary, secondary, ghost, danger, outline, text, reward }

enum SoteriaButtonSize { sm, md, lg }

class SoteriaButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final SoteriaButtonVariant variant;
  final SoteriaButtonSize size;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isFullWidth;
  final bool uppercase;

  const SoteriaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = SoteriaButtonVariant.primary,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.uppercase = true,
  });

  const SoteriaButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.uppercase = true,
  }) : variant = SoteriaButtonVariant.primary;

  const SoteriaButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.uppercase = true,
  }) : variant = SoteriaButtonVariant.secondary;

  const SoteriaButton.outline({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.uppercase = true,
  }) : variant = SoteriaButtonVariant.outline;

  const SoteriaButton.danger({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.uppercase = true,
  }) : variant = SoteriaButtonVariant.danger;

  const SoteriaButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.uppercase = true,
  }) : variant = SoteriaButtonVariant.ghost;

  const SoteriaButton.reward({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.uppercase = true,
  }) : variant = SoteriaButtonVariant.reward;

  const SoteriaButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.uppercase = true,
  }) : variant = SoteriaButtonVariant.text;

  @override
  State<SoteriaButton> createState() => _SoteriaButtonState();
}

class _SoteriaButtonState extends State<SoteriaButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: SoteriaAnimations.fastest,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: widget.label,
      child: GestureDetector(
        onTapDown: (_) => isEnabled ? _controller.forward() : null,
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: () {
          if (isEnabled && !widget.isLoading) {
            HapticFeedback.lightImpact();
            widget.onPressed!();
          }
        },
        child: AnimatedOpacity(
          duration: SoteriaAnimations.fast,
          opacity: isEnabled ? 1.0 : 0.4,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedContainer(
              duration: SoteriaAnimations.fast,
              width: widget.isFullWidth ? double.infinity : null,
              height: _getHeight(),
              padding: _getPadding(),
              decoration: _getDecoration(),
              child: Center(
                child: widget.isLoading
                    ? _buildLoader()
                    : _buildContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getHeight() {
    switch (widget.size) {
      case SoteriaButtonSize.sm:
        return 36.h.clamp(32.0, 40.0);
      case SoteriaButtonSize.md:
        return 48.h.clamp(44.0, 56.0);
      case SoteriaButtonSize.lg:
        return 64.h;
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case SoteriaButtonSize.sm:
        return EdgeInsets.symmetric(horizontal: 16.w);
      case SoteriaButtonSize.md:
        return EdgeInsets.symmetric(horizontal: 24.w);
      case SoteriaButtonSize.lg:
        return EdgeInsets.symmetric(horizontal: 32.w);
    }
  }

  BoxDecoration _getDecoration() {
    final isEnabled = widget.onPressed != null;

    switch (widget.variant) {
      case SoteriaButtonVariant.primary:
        return BoxDecoration(
          gradient: isEnabled ? SoteriaGradients.premiumButton : null,
          color: isEnabled
              ? null
              : SoteriaColors.primary.withValues(alpha: 0.3),
          borderRadius: SoteriaRadius.brLg,
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: SoteriaColors.secondary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        );
      case SoteriaButtonVariant.reward:
        return BoxDecoration(
          gradient: isEnabled ? SoteriaGradients.reward : null,
          color: isEnabled ? null : SoteriaColors.gold.withValues(alpha: 0.3),
          borderRadius: SoteriaRadius.brLg,
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: SoteriaColors.gold.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        );
      case SoteriaButtonVariant.secondary:
        return BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: SoteriaRadius.brMd,
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        );
      case SoteriaButtonVariant.ghost:
        return const BoxDecoration(color: Colors.transparent);
      case SoteriaButtonVariant.danger:
        return BoxDecoration(
          color: SoteriaColors.error.withValues(alpha: 0.15),
          borderRadius: SoteriaRadius.brMd,
          border: Border.all(color: SoteriaColors.error.withValues(alpha: 0.3)),
        );
      case SoteriaButtonVariant.outline:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: SoteriaRadius.brMd,
          border: Border.all(color: SoteriaColors.primary),
        );
      case SoteriaButtonVariant.text:
        return const BoxDecoration(color: Colors.transparent);
    }
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: _getIconSize(), color: _getTextColor()),
          SizedBox(width: 8.w),
        ],
        Text(
          widget.uppercase ? widget.label.toUpperCase() : widget.label,
          style: context.labelLarge.copyWith(
            color: _getTextColor(),
            fontWeight: FontWeight.bold,
            letterSpacing: widget.uppercase ? 1.2 : 0,
          ),
        ),
        if (widget.trailingIcon != null) ...[
          SizedBox(width: 8.w),
          Icon(
            widget.trailingIcon,
            size: _getIconSize(),
            color: _getTextColor(),
          ),
        ],
      ],
    );
  }

  double _getIconSize() {
    switch (widget.size) {
      case SoteriaButtonSize.sm:
        return 14.sp;
      case SoteriaButtonSize.md:
        return 18.sp;
      case SoteriaButtonSize.lg:
        return 20.sp;
    }
  }

  Color _getTextColor() {
    if (widget.onPressed == null) return SoteriaColors.muted;

    switch (widget.variant) {
      case SoteriaButtonVariant.primary:
        return SoteriaColors.textPrimary;
      case SoteriaButtonVariant.reward:
        return Colors.black;
      case SoteriaButtonVariant.secondary:
        return SoteriaColors.textPrimary;
      case SoteriaButtonVariant.ghost:
        return SoteriaColors.primary;
      case SoteriaButtonVariant.danger:
        return SoteriaColors.error;
      case SoteriaButtonVariant.outline:
        return SoteriaColors.primary;
      case SoteriaButtonVariant.text:
        return SoteriaColors.primary;
    }
  }

  Widget _buildLoader() {
    return SizedBox(
      height: 20.h,
      width: 20.h,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
      ),
    );
  }
}
