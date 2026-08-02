import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/blur/soteria_blur.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class GameGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double blur;
  final Color? borderColor;

  const GameGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.blur = SoteriaBlur.medium,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? SoteriaRadius.brXl;

    return ClipRRect(
      borderRadius: br,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: br,
            border: Border.all(
              color: borderColor ?? Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
