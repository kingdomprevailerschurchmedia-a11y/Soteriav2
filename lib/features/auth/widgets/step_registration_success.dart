import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/animations/soteria_animations.dart';

class StepRegistrationSuccess extends StatelessWidget {
  const StepRegistrationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SoteriaScaleIn(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SoteriaColors.success.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.verified_user_rounded,
                  size: 80.w,
                  color: SoteriaColors.success,
                ),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            SoteriaFadeIn(
              delay: const Duration(milliseconds: 400),
              child: Text(
                'Registration Complete',
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            SoteriaFadeIn(
              delay: const Duration(milliseconds: 600),
              child: Text(
                'Welcome to the future of learning. We\'ve sent a verification link to your email.',
                style: context.bodyLarge.copyWith(
                  color: SoteriaColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
