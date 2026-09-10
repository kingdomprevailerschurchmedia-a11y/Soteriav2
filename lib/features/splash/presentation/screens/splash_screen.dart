import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/services/asset_precache_service.dart';

import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';

import '../widgets/splash_branding.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ===========================================================================
  // ANIMATION
  // ===========================================================================

  late final AnimationController _controller;

  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;

  // ===========================================================================
  // STARTUP STATE
  // ===========================================================================

  bool _hasNavigated = false;

  // ===========================================================================
  // INIT
  // ===========================================================================

  @override
  void initState() {
    super.initState();

    _configureSystemUi();
    _initializeAnimations();
    _startStartupProcess();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache immediate splash assets
    precacheImage(const AssetImage('assets/images/splash_bg.webp'), context);
    precacheImage(const AssetImage('assets/images/logo_icon.png'), context);
  }

  // ===========================================================================
  // SYSTEM UI
  // ===========================================================================

  void _configureSystemUi() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  // ===========================================================================
  // ANIMATIONS
  // ===========================================================================

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.40, curve: Curves.easeOut),
    );

    _logoScale = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.40, curve: Curves.easeOutCubic),
      ),
    );
  }

  // ===========================================================================
  // STARTUP
  // ===========================================================================

  Future<void> _startStartupProcess() async {
    _controller.forward();

    // Combine all startup dependencies:
    // 1. Minimum animation time (800ms)
    // 2. App initialization logic
    
    final startupTasks = [
      Future.delayed(const Duration(milliseconds: 800)),
      _waitForAppStartup(),
    ];

    await Future.wait(startupTasks);

    if (!mounted) return;

    final nextState = ref.read(appLifecycleProvider);
    
    if (nextState == AppStartupState.error) {
      // Stay on splash to show error UI
      return;
    }

    // 3. Targeted asset precaching for next screen
    try {
      await _precacheForState(nextState).timeout(
        const Duration(milliseconds: 500),
      );
    } catch (_) {}

    _navigateToDestination();
  }

  Future<void> _precacheForState(AppStartupState state) async {
    if (!mounted) return;
    
    switch (state) {
      case AppStartupState.onboarding:
        await AssetPrecacheService.precacheAssets(
          context,
          AssetPrecacheService.onboardingImages,
        );
        break;
      case AppStartupState.auth:
        await AssetPrecacheService.precacheAssets(
          context,
          AssetPrecacheService.authImages,
        );
        break;
      default:
        // No specific assets for other states yet
        break;
    }
  }

  Future<void> _waitForAppStartup() async {
    final state = ref.read(appLifecycleProvider);
    if (state != AppStartupState.loading) return;

    // Wait for the provider to emit a non-loading state
    final completer = Completer<void>();
    final subscription = ref.listenManual<AppStartupState>(
      appLifecycleProvider,
      (previous, next) {
        if (next != AppStartupState.loading && !completer.isCompleted) {
          completer.complete();
        }
      },
      fireImmediately: true,
    );

    await completer.future;
    subscription.close();
  }

  // ===========================================================================
  // NAVIGATION
  // ===========================================================================

  void _navigateToDestination() {
    if (_hasNavigated) return;
    
    final state = ref.read(appLifecycleProvider);
    if (state == AppStartupState.loading) return;
    
    _hasNavigated = true;
    final String destination;

    switch (state) {
      case AppStartupState.onboarding:
        destination = SoteriaRoutes.onboarding;
        break;

      case AppStartupState.personalization:
        destination = SoteriaRoutes.personalization;
        break;

      case AppStartupState.auth:
        destination = SoteriaRoutes.auth;
        break;

      case AppStartupState.ready:
        destination = SoteriaRoutes.main;
        break;

      case AppStartupState.error:
        // Handle error state - maybe show a dialog or retry button on splash
        _hasNavigated = false; 
        return;

      case AppStartupState.loading:
        _hasNavigated = false;
        return;
    }

    context.go(destination);
  }

  // ===========================================================================
  // DISPOSE
  // ===========================================================================

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appLifecycleProvider);

    return Scaffold(
      backgroundColor: SoteriaColors.backgroundBottomRight,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _SplashBackground(),
          RepaintBoundary(
            child: SplashBranding(
              logoOpacity: _logoOpacity,
              logoScale: _logoScale,
            ),
          ),
          if (state == AppStartupState.error)
            Positioned(
              bottom: 100.h,
              left: 24.w,
              right: 24.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'INITIALIZATION FAILED',
                    style: context.titleMedium.copyWith(
                      color: SoteriaColors.error,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SoteriaButton.secondary(
                    label: 'RETRY',
                    onPressed: () {
                      ref.read(appLifecycleProvider.notifier).refresh();
                      _startStartupProcess();
                    },
                    size: SoteriaButtonSize.sm,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// SPLASH BACKGROUND
// =============================================================================

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SoteriaColors.backgroundBottomRight,
      child: Image.asset(
        'assets/images/splash_bg.webp',
        fit: BoxFit.cover,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
        isAntiAlias: true,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Splash BG Error: $error');
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
