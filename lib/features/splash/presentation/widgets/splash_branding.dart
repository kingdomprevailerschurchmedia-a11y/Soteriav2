import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/config/soteria_branding_config.dart';

class SplashBranding extends StatelessWidget {
  final Animation<double> logoOpacity;
  final Animation<double> logoScale;
  final Animation<double> wordmarkOpacity;
  final Animation<double> taglineOpacity;

  const SplashBranding({
    super.key,
    required this.logoOpacity,
    required this.logoScale,
    required this.wordmarkOpacity,
    required this.taglineOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Prevent rendering with 0 size during initial initialization
    if (size.width == 0 || size.height == 0) {
      return const SizedBox.shrink();
    }

    final logoSize = SoteriaBrandingConfig.getLogoSize(size);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ============================================================
          // GOLD SOTERIA ICON
          // ============================================================
          FadeTransition(
            opacity: logoOpacity,
            child: ScaleTransition(
              scale: logoScale,
              child: Image.asset(
                'assets/images/logo_icon.png',
                width: logoSize,
                height: logoSize,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Logo Icon Error: $error');
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),

          SizedBox(height: SoteriaBrandingConfig.getLogoToWordmarkGap()),

          // ============================================================
          // WORDMARK + TAGLINE (GROUPED)
          // ============================================================
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ============================================================
              // SOTERIA WORDMARK
              // ============================================================
              FadeTransition(
                opacity: wordmarkOpacity,
                child: _Wordmark(size: size),
              ),

              SizedBox(height: SoteriaBrandingConfig.getWordmarkToTaglineGap()),

              // ============================================================
              // TAGLINE
              // ============================================================
              FadeTransition(
                opacity: taglineOpacity,
                child: _Tagline(size: size),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SOTERIA WORDMARK
// ============================================================================

class _Wordmark extends StatelessWidget {
  final Size size;

  const _Wordmark({required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      'SOTERIA',
      maxLines: 1,
      textAlign: TextAlign.center,
      style: SoteriaTypography.displayMedium.copyWith(
        color: SoteriaColors.textPrimary,
        fontSize: SoteriaBrandingConfig.getWordmarkFontSize(size),
        fontWeight: SoteriaBrandingConfig.getWordmarkFontWeight(),
        letterSpacing: SoteriaBrandingConfig.getWordmarkLetterSpacing(),
        height: 1.0,
      ),
    );
  }
}

// ============================================================================
// TAGLINE
// ============================================================================

class _Tagline extends StatelessWidget {
  final Size size;

  const _Tagline({required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      'COMPETE. LEARN. RISE.',
      maxLines: 1,
      textAlign: TextAlign.center,
      style: SoteriaTypography.labelSmall.copyWith(
        color: SoteriaColors.gold,
        fontSize: SoteriaBrandingConfig.getTaglineFontSize(size),
        fontWeight: SoteriaBrandingConfig.getTaglineFontWeight(),
        letterSpacing: SoteriaBrandingConfig.getTaglineLetterSpacing(),
        height: 1.0,
      ),
    );
  }
}
