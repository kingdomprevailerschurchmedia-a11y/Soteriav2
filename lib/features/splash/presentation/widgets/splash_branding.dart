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

    final logoSize = size.width * 0.62; // Increased size (3x, previously 0.208)

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

          SizedBox(height: 8.h),

          // ============================================================
          // SOTERIA WORDMARK
          // ============================================================
          FadeTransition(
            opacity: wordmarkOpacity,
            child: _Wordmark(availableWidth: size.width),
          ),

          SizedBox(height: 4.h),

          // ============================================================
          // TAGLINE
          // ============================================================
          FadeTransition(
            opacity: taglineOpacity,
            child: _Tagline(availableWidth: size.width),
          ),

          // Add a bit of bottom padding to balance the logo's height
          SizedBox(height: size.height * 0.05),
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
     * The supplied artwork uses a clean, thin, widely-spaced
     * wordmark rather than a heavy/bold gaming-style title.
     */

    final fontSize = availableWidth * 0.064;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'SOTERIA',
        maxLines: 1,
        textAlign: TextAlign.center,
        style: SoteriaTypography.displayMedium.copyWith(
          color: SoteriaColors.textPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          letterSpacing: availableWidth * 0.0105,
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
    final fontSize = availableWidth * 0.0205;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'COMPETE. LEARN. RISE.',
        maxLines: 1,
        textAlign: TextAlign.center,
        style: SoteriaTypography.label.copyWith(
          color: SoteriaColors.gold,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: availableWidth * 0.0058,
          height: 1.0,
        ),
      ),
    );
  }
}
