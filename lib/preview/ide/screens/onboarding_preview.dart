import 'package:flutter/material.dart';
import '../../../features/onboarding/screens/onboarding_screen.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const OnboardingPreview());
}

class OnboardingPreview extends StatelessWidget {
  const OnboardingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const PreviewScaffold(child: OnboardingScreen());
  }
}
