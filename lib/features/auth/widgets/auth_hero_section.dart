import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Positioned(
          top: -50,
          child: AmbientGlow(
            color: SoteriaColors.primary,
            size: 300,
            opacity: 0.15,
          ),
        ),
        Column(
          children: [
            SizedBox(height: SoteriaSpacing.xxl),
            Icon(
              Icons.shield_rounded,
              size: 80.w,
              color: SoteriaColors.gold,
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Text(
              'Welcome to Soteria',
              style: context.displayMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 32.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.sm),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.xl),
              child: Text(
                'Compete with the brightest minds. Rise through knowledge.',
                style: context.bodyLarge.copyWith(
                  color: SoteriaColors.textSecondary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
          ],
        ),
      ],
    );
  }
}
