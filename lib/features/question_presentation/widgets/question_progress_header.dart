import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class QuestionProgressHeader extends StatelessWidget {
  const QuestionProgressHeader({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    this.progress = 0.0,
    this.timerChild,
  });

  final int currentQuestion;
  final int totalQuestions;
  final double progress;
  final Widget? timerChild;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUESTION $currentQuestion OF $totalQuestions',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xs),
                Container(
                  width: 120.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: SoteriaRadius.brFull,
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            SoteriaColors.primary,
                            SoteriaColors.secondary,
                          ],
                        ),
                        borderRadius: SoteriaRadius.brFull,
                        boxShadow: [
                          BoxShadow(
                            color: SoteriaColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Fixed layout space for Timer
                if (timerChild != null)
                  timerChild!
                else
                  SizedBox(width: 48.w, height: 48.w),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
