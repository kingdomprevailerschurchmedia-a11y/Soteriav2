import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/design_system/themes/soteria_theme.dart';
import '../widgets/preview_home.dart';

class SoteriaPreviewApp extends ConsumerWidget {
  const SoteriaPreviewApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 13/14 standard
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Soteria Developer Preview',
          debugShowCheckedModeBanner: false,
          theme: SoteriaTheme.darkTheme,
          home: const PreviewHomeScreen(),
        );
      },
    );
  }
}
