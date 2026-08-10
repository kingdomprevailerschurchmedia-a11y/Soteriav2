import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';

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
  late final Animation<double> _textOpacity;

  // ===========================================================================
  // STARTUP STATE
  // ===========================================================================

  ProviderSubscription<AppStartupState>? _startupSubscription;

  bool _minimumSplashDurationComplete = false;
  bool _startupReady = false;
  bool _nativeSplashRemoved = false;
  bool _hasNavigated = false;

  // ===========================================================================
  // INIT
  // ===========================================================================

  @override
  void initState() {
    super.initState();

    _configureSystemUi();
    _initializeAnimations();
    _startSplash();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache assets to ensure they are ready before native splash removal
    precacheImage(const AssetImage('assets/images/splash_bg.png'), context);
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
        systemNavigationBarColor: SoteriaColors.backgroundBottomRight,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor:
        SoteriaColors.backgroundBottomRight,
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

    // -------------------------------------------------------------------------
    // LOGO OPACITY
    //
    // Begins at approximately 150ms.
    // -------------------------------------------------------------------------

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.075,
        0.30,
        curve: Curves.easeOut,
      ),
    );

    // -------------------------------------------------------------------------
    // LOGO SCALE
    //
    // Very subtle:
    // 94% → 100%
    // -------------------------------------------------------------------------

    _logoScale = Tween<double>(
      begin: 0.94,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.075,
          0.30,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    // -------------------------------------------------------------------------
    // WORDMARK + TAGLINE
    //
    // Begins around 500ms.
    // -------------------------------------------------------------------------

    _textOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.25,
        0.45,
        curve: Curves.easeOut,
      ),
    );
  }

  // ===========================================================================
  // STARTUP
  // ===========================================================================

  void _startSplash() {
    // Start the custom Soteria branding animation.
    _controller.forward();

    /*
     * CRITICAL:
     *
     * The native splash is removed only after Flutter has rendered
     * the custom splash screen's first frame.
     *
     * Native splash:
     *     #090514
     *
     * Flutter splash:
     *     splash_bg.png
     *
     * This makes the native → Flutter handoff visually seamless.
     */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _removeNativeSplash();

      /*
       * Minimum branded display time.
       *
       * Startup work continues independently.
       */
      Future<void>.delayed(
        const Duration(milliseconds: 1500),
            () {
          if (!mounted) return;

          _minimumSplashDurationComplete = true;

          _maybeNavigate();
        },
      );
    });

    /*
     * Listen to the application's existing startup state.
     *
     * We do NOT create another authentication system.
     *
     * appLifecycleProvider remains the source of truth.
     */
    _startupSubscription = ref.listenManual<AppStartupState>(
      appLifecycleProvider,
          (previous, next) {
        if (!mounted) return;

        _startupReady = next != AppStartupState.loading;

        _maybeNavigate();
      },
      fireImmediately: true,
    );
  }

  // ===========================================================================
  // NATIVE SPLASH
  // ===========================================================================

  void _removeNativeSplash() {
    if (_nativeSplashRemoved) return;

    _nativeSplashRemoved = true;

    FlutterNativeSplash.remove();
  }

  // ===========================================================================
  // NAVIGATION GATE
  // ===========================================================================

  void _maybeNavigate() {
    if (!mounted) return;
    if (_hasNavigated) return;

    /*
     * Navigation requires BOTH:
     *
     * 1. The branded splash has been visible long enough.
     * 2. Critical application startup is complete.
     */
    if (!_minimumSplashDurationComplete) return;
    if (!_startupReady) return;

    final state = ref.read(appLifecycleProvider);

    if (state == AppStartupState.loading) {
      return;
    }

    _navigateToDestination(state);
  }

  // ===========================================================================
  // NAVIGATION
  // ===========================================================================

  void _navigateToDestination(AppStartupState state) {
    if (!mounted) return;
    if (_hasNavigated) return;

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

      case AppStartupState.loading:
        _hasNavigated = false;
        return;

      default:
        destination = SoteriaRoutes.auth;
        break;
    }

    /*
     * GoRouter remains the application's single navigation authority.
     */
    context.go(destination);
  }

  // ===========================================================================
  // DISPOSE
  // ===========================================================================

  @override
  void dispose() {
    _startupSubscription?.close();
    _controller.dispose();

    super.dispose();
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    /*
     * Soteria is dark-only.
     *
     * Keep system UI consistent with the native splash bridge.
     */
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: SoteriaColors.backgroundBottomRight,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor:
        SoteriaColors.backgroundBottomRight,
      ),
    );

    return Scaffold(
      backgroundColor: SoteriaColors.backgroundBottomRight,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // =================================================================
          // COMPLETE SPLASH BACKGROUND
          //
          // splash_bg.png already contains:
          //
          // • Deep Soteria background
          // • Pattern artwork
          // • Purple atmosphere
          // • Bottom purple horizon/glow
          //
          // Therefore NO additional glow layer is added.
          // =================================================================

          const _SplashBackground(),

          // =================================================================
          // BRANDING
          //
          // SplashBranding is responsible for the precise positioning of:
          //
          // • logo_icon.png
          // • SOTERIA
          // • COMPETE. LEARN. RISE.
          //
          // Do NOT wrap this in Center().
          // =================================================================

          SplashBranding(
            logoOpacity: _logoOpacity,
            logoScale: _logoScale,
            textOpacity: _textOpacity,
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
        'assets/images/splash_bg.png',
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