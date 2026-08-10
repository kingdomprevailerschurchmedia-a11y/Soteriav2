import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_gradient_text.dart';
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
          height: SoteriaSpacing.adaptive(context, SoteriaSpacing.xlStatic),
        ),

        // Premium Glowing Hero Area
        SoteriaScaleIn(
          duration: const Duration(milliseconds: 1000),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Purple Glow behind logo
              Container(
                width: isShort ? 200.w : 250.w,
                height: isShort ? 200.w : 250.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF7C4DFF).withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Shield Logo
              logo ??
                  Image.asset(
                    'assets/images/logo_icon.png',
                    width: isShort ? 80.w : 100.w,
                    height: isShort ? 80.w : 100.w,
                    fit: BoxFit.contain,
                  ),
            ],
          ),
        ),

        SizedBox(
          height: SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
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
                height: SoteriaSpacing.adaptive(
                  context,
                  SoteriaSpacing.xsStatic,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  'Compete with the brightest minds.\nRise through knowledge.',
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
          height: SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
        ),
      ],
    );
  }
}
