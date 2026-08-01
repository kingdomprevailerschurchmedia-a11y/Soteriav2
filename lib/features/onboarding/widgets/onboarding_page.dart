import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
    this.backgroundGlowColor,
    this.offset = 0.0,
  });

  final String title;
  final String description;
  final Widget illustration;
  final Color? backgroundGlowColor;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (backgroundGlowColor != null)
          Positioned(
            top: -100.h,
            right: -100.w,
            child: AmbientGlow(
              color: backgroundGlowColor!.withValues(alpha: 0.15),
              size: 400.w,
            ),
          ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                // Illustration with Parallax and Scale
                Transform.translate(
                  offset: Offset(offset * 100, 0),
                  child: AnimatedScale(
                    scale: 1.0 - (offset.abs() * 0.2),
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedOpacity(
                      opacity: 1.0 - (offset.abs() * 0.5),
                      duration: const Duration(milliseconds: 300),
                      child: illustration,
                    ),
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xxl),
                // Text Content
                Transform.translate(
                  offset: Offset(offset * 50, 0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: context.displayMedium.copyWith(
                          color: SoteriaColors.textPrimary,
                          height: 1.1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SoteriaSpacing.md),
                      Text(
                        description,
                        style: context.bodyLarge.copyWith(
                          color: SoteriaColors.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 150.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
