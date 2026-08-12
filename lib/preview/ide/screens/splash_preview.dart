import 'package:flutter/material.dart';
import '../../../features/splash/presentation/screens/splash_screen.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const SplashPreview());
}

class SplashPreview extends StatelessWidget {
  const SplashPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewScaffold(child: SplashScreen());
  }
}
