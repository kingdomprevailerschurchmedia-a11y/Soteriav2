import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/core/errors/error_handler.dart';
import 'package:soteria/features/notifications/providers/notification_providers.dart';
import 'package:soteria/core/firebase/config/providers/configuration_providers.dart';
import '../firebase/providers/bootstrapper_provider.dart';

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
          data: (_) => _buildApp(context, ref),
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => _buildErrorApp(context, ref, error),
        );
      },
    );
  }

  Widget _buildApp(BuildContext context, WidgetRef ref) {
    // Initialize background services
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationCoordinatorProvider).initialize();
      ref.read(configurationCoordinatorProvider).initialize();
      // Native splash removal is handled by SplashScreen for a smoother transition
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
        return child!;
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
