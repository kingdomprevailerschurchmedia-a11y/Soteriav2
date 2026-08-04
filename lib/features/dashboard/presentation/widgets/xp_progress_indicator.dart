import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';

class XPProgressIndicator extends StatelessWidget {
  const XPProgressIndicator({
    super.key,
    required this.progress,
    required this.level,
    this.size = 80,
    this.strokeWidth = 8,
    this.showLevel = true,
  });

  final double progress;
  final int level;
  final double size;
  final double strokeWidth;
  final bool showLevel;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: strokeWidth,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
                valueColor: const AlwaysStoppedAnimation(SoteriaColors.primary),
                strokeCap: StrokeCap.round,
              ),
            ),
            if (showLevel)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lvl',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontSize: size * 0.125,
                    ),
                  ),
                  Text(
                    level.toString(),
                    style: context.titleLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: size * 0.25,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class XPProgressBar extends StatelessWidget {
  const XPProgressBar({
    super.key,
    required this.progress,
    this.height = 8,
    this.borderRadius = 4,
  });

  final double progress;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
            height: height,
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation(SoteriaColors.primary),
            ),
          ),
        );
      },
    );
  }
}
