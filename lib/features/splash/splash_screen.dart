import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/app/app_bootstrap.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';
import 'package:soteria/core/widgets/animations/soteria_animations.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/widgets/feedback/soteria_error_widget.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start bootstrap after a small delay to allow animations to start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bootstrapStateProvider.notifier).run();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bootstrapState = ref.watch(bootstrapStateProvider);

    // Watch for success and navigate
    ref.listen(bootstrapStateProvider, (previous, next) {
      if (next == BootstrapState.success) {
        final router = GoRouter.of(context);
        // Use a duration that can be handled easily in tests
        final delay = kDebugMode ? const Duration(milliseconds: 100) : const Duration(milliseconds: 800);
        Future.delayed(delay, () {
          router.go(SoteriaRoutes.previewGallery);
        });
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: Stack(
          children: [
            // Ambient Lighting
            const Positioned(
              top: -100,
              left: -100,
              child: AmbientGlow(color: SoteriaColors.primary, size: 400),
            ),
            const Positioned(
              bottom: -150,
              right: -100,
              child: AmbientGlow(color: SoteriaColors.secondary, size: 500, opacity: 0.2),
            ),

            // Main Content
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.xl),
                  child: bootstrapState == BootstrapState.error
                      ? _buildErrorUI()
                      : _buildStartupUI(bootstrapState),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartupUI(BootstrapState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SoteriaBlurTransition(
          duration: const Duration(milliseconds: 800),
          child: SoteriaScaleIn(
            duration: const Duration(milliseconds: 600),
            child: const Icon(
              Icons.shield_rounded,
              size: 80,
              color: SoteriaColors.primary,
            ),
          ),
        ),
        SizedBox(height: SoteriaSpacing.lg),
        SoteriaFadeIn(
          delay: const Duration(milliseconds: 400),
          child: Column(
            children: [
              Text(
                'SOTERIA',
                style: context.displayMedium.copyWith(
                  letterSpacing: 8,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: SoteriaSpacing.xs),
              Text(
                'PREMIUM COMPETITIVE LEARNING',
                style: context.bodySmall.copyWith(
                  letterSpacing: 2,
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.xxl),
        SoteriaFadeIn(
          delay: const Duration(milliseconds: 800),
          child: const SoteriaLoader(size: 32),
        ),
      ],
    );
  }

  Widget _buildErrorUI() {
    return SoteriaErrorWidget(
      message: 'Failed to initialize application foundation.',
      onRetry: () => ref.read(bootstrapStateProvider.notifier).run(),
    );
  }
}
