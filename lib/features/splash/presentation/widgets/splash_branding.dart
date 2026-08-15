import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

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

    final logoSize = size.width * 0.55; // Slightly smaller logo to give text more breathing room

    return Center(
      child: Column(
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

          SizedBox(height: 24.h), // Consistent gap between logo and text

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
                child: _Wordmark(availableWidth: size.width),
              ),

              SizedBox(height: 1.h),

              // ============================================================
              // TAGLINE
              // ============================================================
              FadeTransition(
                opacity: taglineOpacity,
                child: _Tagline(availableWidth: size.width),
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
  final double availableWidth;

  const _Wordmark({required this.availableWidth});

  @override
  Widget build(BuildContext context) {
    /*
     * The wordmark is bold and authoritative as seen in the production branding.
     */

    final fontSize = availableWidth * 0.085; // Increased from 0.064

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'SOTERIA',
        maxLines: 1,
        textAlign: TextAlign.center,
        style: SoteriaTypography.displayMedium.copyWith(
          color: SoteriaColors.textPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.w700, // Bolder to match the "permanent" look
          letterSpacing: availableWidth * 0.015, // Increased spacing
          height: 1.0,
        ),
      ),
    );
  }
}

// ============================================================================
// TAGLINE
// ============================================================================

class _Tagline extends StatelessWidget {
  final double availableWidth;

  const _Tagline({required this.availableWidth});

  @override
  Widget build(BuildContext context) {
    final fontSize = availableWidth * 0.024; // Increased from 0.0205

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'COMPETE. LEARN. RISE.',
        maxLines: 1,
        textAlign: TextAlign.center,
        style: SoteriaTypography.labelSmall.copyWith(
          color: SoteriaColors.gold,
          fontSize: fontSize,
          fontWeight: FontWeight.w900, // Much bolder for visibility
          letterSpacing: availableWidth * 0.008,
          height: 1.0,
        ),
      ),
    );
  }
}
