import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/animations/soteria_animations.dart';

class VerificationStepSuccess extends StatelessWidget {
  const VerificationStepSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SoteriaScaleIn(
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SoteriaColors.success.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.verified_rounded,
                  size: 80.w,
                  color: SoteriaColors.success,
                ),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            Text(
              'Identity Verified',
              style: context.headlineMedium.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'Your account is now secure. You can proceed to the platform.',
              style: context.bodyLarge.copyWith(
                color: SoteriaColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
