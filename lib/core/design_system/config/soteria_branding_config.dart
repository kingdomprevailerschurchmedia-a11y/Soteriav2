import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shared branding geometry constants for Soteria splash screens.
/// 
/// This ensures consistent sizing and positioning across:
/// 1. Native Splash (Android/iOS)
/// 2. SplashStaticView (First Flutter frames)
/// 3. SplashBranding (Animated branding)
class SoteriaBrandingConfig {
  const SoteriaBrandingConfig._();

  /// Logo sizing based on screen width with sensible bounds.
  /// Target visible width: ~175–200dp.
  static double getLogoSize(Size size) {
    // Using a ratio that hits the target range on standard phones.
    // 360dp * 0.5 = 180dp
    // 411dp * 0.5 = 205.5dp (clamped to 205)
    return (size.width * 0.5).clamp(170.0, 205.0);
  }

  /// Wordmark (SOTERIA) font size.
  /// Target: ~28–36sp.
  static double getWordmarkFontSize(Size size) {
    return (size.width * 0.08).clamp(28.0, 36.0);
  }

  /// Tagline (COMPETE. LEARN. RISE.) font size.
  /// Target: ~10–12sp.
  static double getTaglineFontSize(Size size) {
    return (size.width * 0.028).clamp(10.0, 12.0);
  }

  /// Vertical gap between logo and wordmark.
  /// Target visible gap: ~18–24dp.
  static double getLogoToWordmarkGap() => 20.h;

  /// Vertical gap between wordmark and tagline.
  /// Target: ~2–4dp.
  static double getWordmarkToTaglineGap() => 3.h;

  /// Wordmark font weight.
  /// Target: 400–500.
  static FontWeight getWordmarkFontWeight() => FontWeight.w400;

  /// Tagline font weight.
  /// Target: 500–600.
  static FontWeight getTaglineFontWeight() => FontWeight.w500;

  /// Wordmark letter spacing.
  /// Target: ~5.0.
  static double getWordmarkLetterSpacing() => 5.0;

  /// Tagline letter spacing.
  /// Target: ~2.2.
  static double getTaglineLetterSpacing() => 2.2;
}
