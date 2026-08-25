import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';

import '../../../../core/utils/soteria_responsive.dart';
import '../../../../core/design_system/config/soteria_branding_config.dart';

class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key, this.logo});

  final Widget? logo;

  @override
  Widget build(BuildContext context) {
    final isShort = SoteriaResponsive.isShortScreen(context);

    return Column(
      children: [
        SizedBox(height: 0),

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

              // Purple Glow behind logo
              Container(
                width: SoteriaBrandingConfig.getLogoSize(MediaQuery.sizeOf(context)) * 1.2,
                height: SoteriaBrandingConfig.getLogoSize(MediaQuery.sizeOf(context)) * 1.2,
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

              // Shield Logo (Synced with Splash Screen dimensions)
              logo ??
                  Image.asset(
                    'assets/images/logo_icon.png',
                    width: SoteriaBrandingConfig.getLogoSize(MediaQuery.sizeOf(context)),
                    height: SoteriaBrandingConfig.getLogoSize(MediaQuery.sizeOf(context)),
                    fit: BoxFit.contain,
                  ),
            ],
          ),
        ),

        SizedBox(height: 12.h),
      ],
    );
  }
}
