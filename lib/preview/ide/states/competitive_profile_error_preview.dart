import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/player/presentation/screens/competitive_profile_screen.dart';
import '../../../features/player/presentation/providers/competitive_profile_provider.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const CompetitiveProfileErrorPreview());
}

class CompetitiveProfileErrorPreview extends StatelessWidget {
  const CompetitiveProfileErrorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewScaffold(
      overrides: [
        competitiveProfileProvider.overrideWithValue(
          AsyncValue.error('Network failure', StackTrace.current),
        ),
      ],
      child: const CompetitiveProfileScreen(),
    );
  }
}
