import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/services/asset_precache_service.dart';

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
  late final Animation<double> _wordmarkOpacity;
  late final Animation<double> _taglineOpacity;

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
      duration: const Duration(milliseconds: 2000),
    );

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.20, curve: Curves.easeOut),
    );

    _logoScale = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.20, curve: Curves.easeOutCubic),
      ),
    );

    _wordmarkOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.35, curve: Curves.easeOut),
    );

    _taglineOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.30, 0.50, curve: Curves.easeOut),
    );
  }

  // ===========================================================================
  // STARTUP
  // ===========================================================================

  Future<void> _startStartupProcess() async {
    _controller.forward();

    // Combine all startup dependencies:
    // 1. Minimum animation time (2s)
    // 2. Asset precaching for next screens
    // 3. App initialization logic
    
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 2000)),
      AssetPrecacheService.precacheAllCriticalAssets(context),
      _waitForAppStartup(),
    ]);

    if (!mounted) return;
    _navigateToDestination();
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
    _hasNavigated = true;

    final state = ref.read(appLifecycleProvider);
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

      case AppStartupState.loading:
        // Should not happen due to _waitForAppStartup
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
    return Scaffold(
      backgroundColor: SoteriaColors.backgroundBottomRight,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _SplashBackground(),
          SplashBranding(
            logoOpacity: _logoOpacity,
            logoScale: _logoScale,
            wordmarkOpacity: _wordmarkOpacity,
            taglineOpacity: _taglineOpacity,
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
