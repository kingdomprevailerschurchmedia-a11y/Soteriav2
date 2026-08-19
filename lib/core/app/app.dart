import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/core/errors/error_handler.dart';
import 'package:soteria/features/auth/services/auth_coordinator.dart';
import 'package:soteria/features/player/presentation/providers/presence_coordinator.dart';
import 'package:soteria/features/notifications/providers/notification_providers.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import 'package:soteria/core/firebase/providers/bootstrapper_provider.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/player/presentation/widgets/rank_celebration_listener.dart';
import 'package:soteria/features/player/presentation/widgets/streak_celebration_listener.dart';
import 'package:soteria/features/player/presentation/providers/goal_providers.dart';
import 'package:soteria/features/player/presentation/providers/milestone_providers.dart';

class SoteriaApp extends ConsumerWidget {
  const SoteriaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseInit = ref.watch(firebaseInitFutureProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 13/14 size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return firebaseInit.when(
          data: (_) {
            // Remove native splash only after we have data and are ready to build the app
            FlutterNativeSplash.remove();
            return _buildApp(context, ref);
          },
          loading: () {
            // Native splash remains visible.
            // We return a minimal themed Container to avoid any white flash
            // if the system removes the native splash before Flutter is ready.
            return Container(color: SoteriaColors.backgroundBottomRight);
          },
          error: (error, stack) => _buildErrorApp(context, ref, error),
        );
      },
    );
  }

  Widget _buildApp(BuildContext context, WidgetRef ref) {
    // Ensure auth/session/presence management is active
    ref.watch(authCoordinatorProvider);
    ref.watch(presenceCoordinatorProvider);
    ref.watch(playerAvatarSyncProvider);
    ref.watch(playerLeaderboardSyncProvider);

    // Ensure real-time goal and milestone evaluation across the entire app
    ref.watch(goalEvaluationProvider);
    ref.watch(milestoneEvaluationProvider);

    // Initialize background services with a staggered delay to ensure splash animation is smooth
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 1. Critical but can wait a bit
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!ref.exists(notificationCoordinatorProvider)) return;
        ref.read(notificationCoordinatorProvider).initialize();
      });

      // 2. Non-critical background observers
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (!ref.exists(configurationCoordinatorProvider)) return;
        ref.read(configurationCoordinatorProvider).initialize();
        ref.read(competitiveEventObserverProvider);
      });
    });

    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Soteria',
      debugShowCheckedModeBanner: false,
      theme: SoteriaTheme.darkTheme,
      routerConfig: router,
      builder: (context, child) {
        if (!kDebugMode || !Platform.environment.containsKey('FLUTTER_TEST')) {
          ErrorWidget.builder = ErrorHandler.errorWidgetBuilder;
        }
        return StreakCelebrationListener(
          child: RankCelebrationListener(child: child!),
        );
      },
    );
  }

  Widget _buildErrorApp(BuildContext context, WidgetRef ref, Object error) {
    // Ensure native splash is removed if we hit a fatal error
    FlutterNativeSplash.remove();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SoteriaTheme.darkTheme,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                Text(
                  'Initialization Failed',
                  style: SoteriaTheme.darkTheme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: SoteriaTheme.darkTheme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => ref.refresh(firebaseInitFutureProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
