import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/config/soteria_branding_config.dart';

class SplashBranding extends StatelessWidget {
  final Animation<double> logoOpacity;
  final Animation<double> logoScale;

  const SplashBranding({
    super.key,
    required this.logoOpacity,
    required this.logoScale,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Prevent rendering with 0 size during initial initialization
    if (size.width == 0 || size.height == 0) {
      return const SizedBox.shrink();
    }

    final logoSize = SoteriaBrandingConfig.getLogoSize(size) * 1.3;

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
        ],
      ),
    );
  }
}
