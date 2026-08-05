import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';

class SoteriaProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color? color;
  final bool hasGlow;

  const SoteriaProgressBar({
    super.key,
    required this.progress,
    this.height = 8.0,
    this.color,
    this.hasGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? SoteriaColors.primary;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress.clamp(0.0, 1.0)),
      duration: SoteriaAnimations.slow,
      curve: SoteriaAnimations.emphasize,
      builder: (context, value, child) {
        return Container(
          height: height.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: SoteriaRadius.brFull,
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    color: effectiveColor,
                    borderRadius: SoteriaRadius.brFull,
                    boxShadow: hasGlow
                        ? [
                            BoxShadow(
                              color: effectiveColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 0),
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
