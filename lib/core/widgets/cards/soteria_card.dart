import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';

/// A standard surface container for content.
///
/// Can be [isElevated] to use the elevated surface color and shadow.
class SoteriaCard extends StatelessWidget {
  const SoteriaCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.isElevated = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool isElevated;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: SoteriaRadius.brLg,
          child: Ink(
            padding: padding ?? EdgeInsets.all(SoteriaSpacing.lg),
            decoration: BoxDecoration(
              color: isElevated ? SoteriaColors.elevatedSurface : SoteriaColors.surface,
              borderRadius: SoteriaRadius.brLg,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
              ),
              boxShadow: isElevated
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
