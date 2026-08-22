import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/design_system/themes/soteria_theme.dart';
import '../providers/preview_provider_overrides.dart';

class PreviewScaffold extends StatelessWidget {
  final Widget child;
  final List<dynamic> overrides;
  final Size? designSize;

  const PreviewScaffold({
    super.key,
    required this.child,
    this.overrides = const [],
    this.designSize,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [...getBasePreviewOverrides(), ...overrides],
      child: ScreenUtilInit(
        designSize: designSize ?? const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: SoteriaTheme.darkTheme,
          home: Scaffold(body: child),
        ),
      ),
    );
  }
}
