import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class SplashBranding extends StatelessWidget {
  final Animation<double> logoOpacity;
  final Animation<double> logoScale;
  final Animation<double> textOpacity;

  const SplashBranding({
    super.key,
    required this.logoOpacity,
    required this.logoScale,
    required this.textOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Prevent rendering with 0 size during initial initialization
    if (size.width == 0 || size.height == 0) {
      return const SizedBox.shrink();
    }

    final logoSize = size.width * 0.208;

    return Stack(
      fit: StackFit.expand,
      children: [
        // ============================================================
        // GOLD SOTERIA ICON
        // ============================================================

        Positioned(
          top: size.height * 0.412,
          left: 0,
          right: 0,
          child: Center(
            child: FadeTransition(
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
          ),
        ),

        // ============================================================
        // SOTERIA WORDMARK
        // ============================================================

        Positioned(
          top: size.height * 0.523,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: textOpacity,
            child: Center(
              child: _Wordmark(
                availableWidth: size.width,
              ),
            ),
          ),
        ),

        // ============================================================
        // TAGLINE
        // ============================================================

        Positioned(
          top: size.height * 0.560,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: textOpacity,
            child: Center(
              child: _Tagline(
                availableWidth: size.width,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SOTERIA WORDMARK
// ============================================================================

class _Wordmark extends StatelessWidget {
  final double availableWidth;

  const _Wordmark({
    required this.availableWidth,
  });

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

  const _Tagline({
    required this.availableWidth,
  });

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