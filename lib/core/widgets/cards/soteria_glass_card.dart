import 'package:flutter/material.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';

class SoteriaGlassCard extends StatelessWidget {
  const SoteriaGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.blur,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? blur;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: SoteriaRadius.brLg,
          child: GlassSurface(
            blur: blur ?? 16.0,
            borderRadius: SoteriaRadius.brLg,
            padding: padding ?? EdgeInsets.all(SoteriaSpacing.lg),
            child: child,
          ),
        ),
      ),
    );
  }
}
