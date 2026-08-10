import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';

class AudienceDistributionOverlay extends StatelessWidget {
  const AudienceDistributionOverlay({
    super.key,
    required this.distribution,
    required this.optionLetters,
  });

  final Map<String, double> distribution;
  final Map<String, String> optionLetters; // optionId -> 'A', 'B', etc.

  @override
  Widget build(BuildContext context) {
    if (distribution.isEmpty) return const SizedBox.shrink();

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: SoteriaAnimations.normal,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(SoteriaSpacing.lg),
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        decoration: BoxDecoration(
          color: SoteriaColors.background.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(SoteriaRadius.xl),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.people_rounded,
                  color: SoteriaColors.secondary,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'AUDIENCE FEEDBACK',
                  style: context.labelMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.lg),
            ...distribution.entries.map((entry) {
              final letter = optionLetters[entry.key] ?? '?';
              final percent = (entry.value * 100).round();

              return Padding(
                padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Option $letter',
                          style: context.labelSmall.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '$percent%',
                          style: context.labelSmall.copyWith(
                            color: SoteriaColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Stack(
                      children: [
                        Container(
                          height: 8.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: entry.value),
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) {
                            return Container(
                              height: 8.h,
                              width:
                                  (MediaQuery.of(context).size.width - 80) *
                                  value,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    SoteriaColors.primary,
                                    SoteriaColors.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: SoteriaColors.primary.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
