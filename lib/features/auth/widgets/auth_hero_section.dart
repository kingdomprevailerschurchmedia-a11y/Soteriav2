import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_gradient_text.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';

class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key, this.logo});

  final Widget? logo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.h),

        // Premium Glowing Hero Area
        SoteriaScaleIn(
          duration: const Duration(milliseconds: 1000),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Multiple Glow Layers
              Container(
                width: 180.w,
                height: 180.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      SoteriaColors.primary.withValues(alpha: 0.25),
                      SoteriaColors.secondary.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Shield / Logo Container with Glass Effect
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: SoteriaColors.primary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: SoteriaColors.primary.withValues(alpha: 0.3),
                      blurRadius: 40,
                      spreadRadius: -10,
                    ),
                  ],
                ),
                child:
                    logo ??
                    Image.asset(
                      'assets/images/logo_icon.png',
                      width: 90.w,
                      height: 90.w,
                      fit: BoxFit.contain,
                    ),
              ),

              // Gold Shimmer Effect (Subtle)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.05,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          SoteriaColors.gold,
                          Colors.transparent,
                        ],
                        stops: [0.4, 0.5, 0.6],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: SoteriaSpacing.xxl),

        // Welcome Text with Gradient
        SoteriaFadeIn(
          delay: const Duration(milliseconds: 400),
          child: Column(
            children: [
              SoteriaGradientText(
                'Welcome to Soteria',
                gradient: const LinearGradient(
                  colors: [SoteriaColors.secondary, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                style: context.headlineLarge.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 36.sp,
                  letterSpacing: -1.0,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: SoteriaSpacing.md),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  'Compete with the brightest minds.\nRise through knowledge.',
                  style: context.bodyLarge.copyWith(
                    color: SoteriaColors.textSecondary,
                    height: 1.6,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: SoteriaSpacing.xxl),
      ],
    );
  }
}
