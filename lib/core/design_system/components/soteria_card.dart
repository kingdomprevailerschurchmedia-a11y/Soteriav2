import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/blur/soteria_blur.dart';
import 'package:soteria/core/widgets/glass_surface.dart';

class SoteriaCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? borderColor;
  final bool hasGlow;
  final Color? glowColor;
  final VoidCallback? onTap;
  final bool isElevated;

  const SoteriaCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderColor,
    this.hasGlow = false,
    this.glowColor,
    this.onTap,
    this.isElevated = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? SoteriaRadius.lg;

    Widget content = GlassSurface(
      borderRadius: BorderRadius.circular(effectiveRadius),
      padding: padding ?? EdgeInsets.all(SoteriaSpacing.lg),
      opacity: isElevated ? 0.12 : 0.08,
      border: Border.all(
        color: borderColor ?? Colors.white.withValues(alpha: 0.08),
        width: 1,
      ),
      child: child,
    );

    if (hasGlow || isElevated) {
      content = Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(effectiveRadius),
          boxShadow: [
            if (hasGlow)
              BoxShadow(
                color: (glowColor ?? SoteriaColors.primary).withValues(
                  alpha: 0.15,
                ),
                blurRadius: 30,
                spreadRadius: -10,
              ),
            if (isElevated)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: content,
      );
    } else if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }

    return content;
  }
}
