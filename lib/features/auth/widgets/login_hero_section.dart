import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

class LoginHeroSection extends StatelessWidget {
  const LoginHeroSection({super.key, this.userName});

  final String? userName;

  @override
  Widget build(BuildContext context) {
    final greeting = userName != null ? 'Welcome back, $userName' : 'Welcome Back';

    return Stack(
      alignment: Alignment.center,
      children: [
        const Positioned(
          top: -50,
          child: AmbientGlow(
            color: SoteriaColors.secondary,
            size: 300,
            opacity: 0.15,
          ),
        ),
        Column(
          children: [
            SizedBox(height: SoteriaSpacing.xxl),
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.3), width: 2),
                gradient: RadialGradient(
                  colors: [
                    SoteriaColors.gold.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Icon(
                Icons.person_outline_rounded,
                size: 50.w,
                color: SoteriaColors.gold,
              ),
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Text(
              greeting,
              style: context.headlineMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.sm),
            Text(
              'Continue your journey. Compete. Learn. Rise.',
              style: context.bodyMedium.copyWith(
                color: SoteriaColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.xl),
          ],
        ),
      ],
    );
  }
}
