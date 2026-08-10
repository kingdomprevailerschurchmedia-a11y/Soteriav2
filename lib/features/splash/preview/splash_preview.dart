import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../presentation/screens/splash_screen.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class SplashPreview extends StatelessWidget {
  final Size? deviceSize;
  final bool reducedMotion;

  const SplashPreview({super.key, this.deviceSize, this.reducedMotion = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SoteriaTheme.darkTheme,
      child: MediaQuery(
        data: MediaQueryData(
          size: deviceSize ?? const Size(390, 844),
          padding: EdgeInsets.only(top: 44.h, bottom: 34.h),
          navigationMode: NavigationMode.directional,
          accessibleNavigation: false,
          disableAnimations: reducedMotion,
        ),
        child: const ProviderScope(child: SplashScreen()),
      ),
    );
  }
}

// Preview states for the gallery
class SplashPreviewGallery extends StatelessWidget {
  const SplashPreviewGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        _buildPreviewSection(
          title: 'Default (iPhone 13/14)',
          child: const SizedBox(height: 600, child: SplashPreview()),
        ),
        _buildPreviewSection(
          title: 'Small Phone (Pixel 4)',
          child: const SizedBox(
            height: 600,
            child: SplashPreview(deviceSize: Size(360, 640)),
          ),
        ),
        _buildPreviewSection(
          title: 'Tablet (iPad Pro 11")',
          child: const SizedBox(
            height: 800,
            child: SplashPreview(deviceSize: Size(834, 1194)),
          ),
        ),
        _buildPreviewSection(
          title: 'Reduced Motion',
          child: const SizedBox(
            height: 600,
            child: SplashPreview(reducedMotion: true),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: SoteriaTypography.titleMedium.copyWith(color: Colors.white),
        ),
        SizedBox(height: 12.h),
        ClipRRect(borderRadius: BorderRadius.circular(16.r), child: child),
        SizedBox(height: 32.h),
      ],
    );
  }
}
