import 'package:flutter/material.dart';
import '../../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../../features/dashboard/presentation/providers/dashboard_providers.dart';
import '../../../features/dashboard/domain/models/dashboard_state.dart';
import '../../../features/player/presentation/providers/progression_providers.dart';
import '../../../features/player/presentation/providers/season_providers.dart';
import '../preview_scaffold.dart';
import '../mock/mock_profile_data.dart';

void main() {
  runApp(const DashboardPreview());
}

class DashboardPreview extends StatelessWidget {
  const DashboardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewScaffold(
      overrides: [
        dashboardProvider.overrideWith(() => MockDashboardNotifier()),
        competitiveProgressionProvider.overrideWith(
          (ref) => Stream.value(MockProfileData.mockProgression),
        ),
        currentSeasonProvider.overrideWith(
          (ref) => Stream.value(MockProfileData.mockProfile.currentSeason),
        ),
      ],
      child: const DashboardScreen(),
    );
  }
}

class MockDashboardNotifier extends DashboardNotifier {
  @override
  DashboardState build() {
    return DashboardState(
      player: MockProfileData.mockPlayer,
      announcements: ['Welcome to Season 8!', 'Double XP weekend starts now!'],
      greeting: 'Good Evening',
    );
  }
}
