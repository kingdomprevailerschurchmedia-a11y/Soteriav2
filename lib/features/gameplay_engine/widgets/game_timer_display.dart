import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class GameTimerDisplay extends StatelessWidget {
  final int secondsRemaining;
  final int totalSeconds;
  final bool isWarning;

  const GameTimerDisplay({
    super.key,
    required this.secondsRemaining,
    required this.totalSeconds,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final progress = secondsRemaining / totalSeconds;
    final color = secondsRemaining <= 5
        ? SoteriaColors.error
        : SoteriaColors.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 64.w,
              height: 64.w,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 4.w,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                color: color,
              ),
            ),
            Text(
              secondsRemaining.toString(),
              style: context.headlineMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
