import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/themes/soteria_theme.dart';
import 'package:soteria/core/navigation/app_router.dart';
import 'package:soteria/core/errors/error_handler.dart';

class SoteriaApp extends ConsumerWidget {
  const SoteriaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 13/14 size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Soteria',
          debugShowCheckedModeBanner: false,
          theme: SoteriaTheme.darkTheme,
          routerConfig: AppRouter.router,
          builder: (context, child) {
            if (!kDebugMode || !Platform.environment.containsKey('FLUTTER_TEST')) {
              ErrorWidget.builder = ErrorHandler.errorWidgetBuilder;
            }
            return child!;
          },
        );
      },
    );
  }
}
