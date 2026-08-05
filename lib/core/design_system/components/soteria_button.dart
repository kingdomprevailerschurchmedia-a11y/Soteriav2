import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

enum SoteriaButtonVariant { primary, secondary, ghost, danger, outline, text }

enum SoteriaButtonSize { sm, md, lg }

class SoteriaButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final SoteriaButtonVariant variant;
  final SoteriaButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;

  const SoteriaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = SoteriaButtonVariant.primary,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
  });

  const SoteriaButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
  }) : variant = SoteriaButtonVariant.primary;

  const SoteriaButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
  }) : variant = SoteriaButtonVariant.secondary;

  const SoteriaButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
  }) : variant = SoteriaButtonVariant.ghost;

  const SoteriaButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.size = SoteriaButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
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
    return Semantics(
      button: true,
      enabled: widget.onPressed != null,
      label: widget.label,
      child: GestureDetector(
        onTapDown: (_) =>
            widget.onPressed != null ? _controller.forward() : null,
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: () {
          if (widget.onPressed != null && !widget.isLoading) {
            HapticFeedback.lightImpact();
            widget.onPressed!();
          }
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: SoteriaAnimations.fast,
            width: widget.isFullWidth ? double.infinity : null,
            height: _getHeight(),
            padding: _getPadding(),
            decoration: _getDecoration(),
            child: Center(
              child: widget.isLoading ? _buildLoader() : _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }

  double _getHeight() {
    switch (widget.size) {
      case SoteriaButtonSize.sm:
        return 36.h;
      case SoteriaButtonSize.md:
        return 48.h;
      case SoteriaButtonSize.lg:
        return 56.h;
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
          color: isEnabled
              ? SoteriaColors.primary
              : SoteriaColors.primary.withValues(alpha: 0.3),
          borderRadius: SoteriaRadius.brMd,
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: SoteriaColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
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
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: _getIconSize(), color: _getTextColor()),
          SizedBox(width: 8.w),
        ],
        Text(
          widget.label.toUpperCase(),
          style: context.labelMedium.copyWith(
            color: _getTextColor(),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
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
