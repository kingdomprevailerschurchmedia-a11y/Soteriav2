import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/core/errors/error_handler.dart';
import '../firebase/providers/bootstrapper_provider.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/splash/initialization_failure_screen.dart';

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
          loading: () => const _BootstrapWrapper(child: SplashScreen()),
          error: (error, stack) => _BootstrapWrapper(
            child: InitializationFailureScreen(
              error: error,
              onRetry: () => ref.refresh(firebaseInitFutureProvider),
            ),
          ),
        );
      },
    );
  }

  Widget _buildApp(BuildContext context, WidgetRef ref) {
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
}

class _BootstrapWrapper extends StatelessWidget {
  final Widget child;
  const _BootstrapWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SoteriaTheme.darkTheme,
      home: child,
    );
  }
}
