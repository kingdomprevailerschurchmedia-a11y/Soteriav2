import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/player/presentation/screens/competitive_profile_screen.dart';
import '../../../features/player/presentation/providers/competitive_profile_provider.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const CompetitiveProfileLoadingPreview());
}

class CompetitiveProfileLoadingPreview extends StatelessWidget {
  const CompetitiveProfileLoadingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewScaffold(
      overrides: [
        competitiveProfileProvider.overrideWithValue(
          const AsyncValue.loading(),
        ),
      ],
      child: const CompetitiveProfileScreen(),
    );
  }
}
