import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/player/presentation/screens/competitive_profile_screen.dart';
import '../../../features/player/presentation/providers/competitive_profile_provider.dart';
import '../../../features/player/presentation/providers/goal_providers.dart';
import '../../../features/player/presentation/providers/streak_providers.dart';
import '../preview_scaffold.dart';
import '../mock/mock_profile_data.dart';
import 'preview_devices.dart';

void main() {
  runApp(const SmallPhoneProfilePreview());
}

class SmallPhoneProfilePreview extends StatelessWidget {
  const SmallPhoneProfilePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewScaffold(
      designSize: PreviewDevices.iphoneSE,
      overrides: [
        competitiveProfileProvider.overrideWithValue(
          AsyncValue.data(MockProfileData.mockProfile),
        ),
        playerGoalsProvider.overrideWith((ref) => Stream.value([])),
        currentWinStreakProvider.overrideWith((ref) => Stream.value(null)),
        goalRefreshProvider.overrideWith((ref) async {}),
        goalEvaluationProvider.overrideWith((ref) {}),
      ],
      child: const CompetitiveProfileScreen(),
    );
  }
}
