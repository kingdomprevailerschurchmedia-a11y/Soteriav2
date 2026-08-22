import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/borders/soteria_borders.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.blur = 12.0, // Reduced from 32.0 for 60fps scrolling
    this.opacity = 0.05,
    this.borderRadius,
    this.padding,
    this.border,
    this.onTap,
    this.useBlur = true,
  });

  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final bool useBlur;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        borderRadius: borderRadius ?? SoteriaRadius.brMd,
        border: border ?? SoteriaBorders.glassBorder,
      ),
      child: child,
    );

    if (useBlur && blur > 0) {
      content = ClipRRect(
        borderRadius: borderRadius ?? SoteriaRadius.brMd,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: content,
        ),
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
