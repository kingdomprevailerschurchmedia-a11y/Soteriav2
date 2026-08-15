import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

/// A simplified, non-animated version of the splash screen branding.
/// 
/// Used during the very first frames of application startup (while Firebase
/// and other critical services are bootstrapping) to ensure the user sees
/// a themed interface immediately after the native splash disappears.
class SplashStaticView extends StatelessWidget {
  const SplashStaticView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: SoteriaColors.backgroundBottomRight,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Container(
            color: SoteriaColors.backgroundBottomRight,
            child: Image.asset(
              'assets/images/splash_bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          
          // Branding
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_icon.png',
                  width: size.width * 0.55,
                  height: size.width * 0.55,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 24.h),
                Text(
                  'SOTERIA',
                  style: SoteriaTypography.displayMedium.copyWith(
                    color: SoteriaColors.textPrimary,
                    fontSize: size.width * 0.085,
                    fontWeight: FontWeight.w700,
                    letterSpacing: size.width * 0.015,
                    height: 1.0,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'COMPETE. LEARN. RISE.',
                  style: SoteriaTypography.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    fontSize: size.width * 0.024,
                    fontWeight: FontWeight.w900,
                    letterSpacing: size.width * 0.008,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
