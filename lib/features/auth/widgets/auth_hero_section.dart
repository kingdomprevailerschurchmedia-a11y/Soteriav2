import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';

import '../../../../core/utils/soteria_responsive.dart';

class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key, this.logo});

  final Widget? logo;

  @override
  Widget build(BuildContext context) {
    final isShort = SoteriaResponsive.isShortScreen(context);

    return Column(
      children: [
        SizedBox(
          height: 24.h,
        ),

        // Premium Glowing Hero Area
        SoteriaScaleIn(
          duration: const Duration(milliseconds: 1000),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Large Top Arc Glow (from the image)
              Positioned(
                top: -300.h,
                child: Container(
                  width: 500.w,
                  height: 500.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF7C4DFF).withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Purple Glow behind logo (Resized for larger logo)
              Container(
                width: isShort ? 140.w : 180.w,
                height: isShort ? 140.w : 180.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF7C4DFF).withValues(alpha: 0.25),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Shield Logo (Increased 3x)
              logo ??
                  Image.asset(
                    'assets/images/logo_icon.png',
                    width: isShort ? 90.w : 120.w,
                    height: isShort ? 90.w : 120.w,
                    fit: BoxFit.contain,
                  ),
            ],
          ),
        ),

        SizedBox(
          height: 2.h,
        ),

        // Welcome Text with Gradient
        SoteriaFadeIn(
          delay: const Duration(milliseconds: 400),
          child: Column(
            children: [
              Text(
                'Welcome to Soteria',
                style: context.headlineLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isShort ? 30.sp : 40.sp,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 8.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  'Rise through knowledge.',
                  style: context.bodyLarge.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                    height: 1.4,
                    fontSize: isShort ? 15.sp : 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 32.h,
        ),
      ],
    );
  }
}
