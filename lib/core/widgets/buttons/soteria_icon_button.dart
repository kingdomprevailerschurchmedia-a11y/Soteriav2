import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class SoteriaIconButton extends StatelessWidget {
  const SoteriaIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.iconSize = 24,
    this.isGlass = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final bool isGlass;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: SoteriaRadius.brFull,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isGlass 
                ? Colors.white.withValues(alpha: 0.05) 
                : SoteriaColors.surface.withValues(alpha: 0.5),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: SoteriaColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
