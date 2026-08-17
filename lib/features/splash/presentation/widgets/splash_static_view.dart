import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/config/soteria_branding_config.dart';

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

    // Prevent rendering with 0 size during initial initialization
    if (size.width == 0 || size.height == 0) {
      return const SizedBox.shrink();
    }

    final logoSize = SoteriaBrandingConfig.getLogoSize(size);

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
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_icon.png',
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: SoteriaBrandingConfig.getLogoToWordmarkGap()),
                Text(
                  'SOTERIA',
                  textAlign: TextAlign.center,
                  style: SoteriaTypography.displayMedium.copyWith(
                    color: SoteriaColors.textPrimary,
                    fontSize: SoteriaBrandingConfig.getWordmarkFontSize(size),
                    fontWeight: SoteriaBrandingConfig.getWordmarkFontWeight(),
                    letterSpacing: SoteriaBrandingConfig.getWordmarkLetterSpacing(),
                    height: 1.0,
                  ),
                ),
                SizedBox(height: SoteriaBrandingConfig.getWordmarkToTaglineGap()),
                Text(
                  'COMPETE. LEARN. RISE.',
                  textAlign: TextAlign.center,
                  style: SoteriaTypography.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    fontSize: SoteriaBrandingConfig.getTaglineFontSize(size),
                    fontWeight: SoteriaBrandingConfig.getTaglineFontWeight(),
                    letterSpacing: SoteriaBrandingConfig.getTaglineLetterSpacing(),
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

