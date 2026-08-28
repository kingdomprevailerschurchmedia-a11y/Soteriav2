import 'package:flutter/material.dart';

/// A service to handle early loading and caching of image assets.
/// 
/// This prevents stutters and "pop-in" effects when navigating between
/// screens for the first time.
class AssetPrecacheService {
  AssetPrecacheService._();

  /// Images for the onboarding flow.
  static const List<String> onboardingImages = [
    'assets/images/rise.png',
    'assets/images/challenge.png',
    'assets/images/recognition.png',
    'assets/images/ready.png',
  ];

  /// Images for the authentication flow.
  static const List<String> authImages = [
    'assets/images/welcome_illustration.png',
    'assets/icons/icons8-google-48.png',
  ];

  /// Precaches a list of asset images.
  static Future<void> precacheAssets(
    BuildContext context,
    List<String> assetPaths,
  ) async {
    for (final path in assetPaths) {
      try {
        await precacheImage(AssetImage(path), context);
      } catch (e) {
        debugPrint('Failed to precache asset: $path. Error: $e');
      }
    }
  }

  /// Precaches all critical app assets.
  static Future<void> precacheAllCriticalAssets(BuildContext context) async {
    await Future.wait([
      precacheAssets(context, onboardingImages),
      precacheAssets(context, authImages),
    ]);
  }
}
