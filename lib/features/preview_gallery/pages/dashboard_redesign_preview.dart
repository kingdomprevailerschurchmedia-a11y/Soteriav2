import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:soteria/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:soteria/features/player/providers/player_providers.dart';
import 'package:soteria/features/dashboard/domain/models/dashboard_state.dart';
import 'package:soteria/features/player/domain/models/progression.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';

enum DashboardScenario {
  defaultView,
  loading,
  empty,
  error,
  offline,
  newUser,
  returningUser,
  activeTournament,
  doubleXP,
  maxLevel,
}

class DashboardRedesignPreview extends StatefulWidget {
  const DashboardRedesignPreview({super.key});

  @override
  State<DashboardRedesignPreview> createState() =>
      _DashboardRedesignPreviewState();
}

class _DashboardRedesignPreviewState extends State<DashboardRedesignPreview> {
  DashboardScenario _scenario = DashboardScenario.defaultView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Redesign'),
        backgroundColor: Colors.transparent,
        actions: [_buildScenarioSelector()],
      ),
      body: ProviderScope(
        overrides: [
          dashboardProvider.overrideWith(
            () => _MockDashboardNotifier(_scenario),
          ),
          playerProgressionProvider.overrideWithValue(
            _getMockProgression(_scenario),
          ),
        ],
        child: const DashboardScreen(),
      ),
    );
  }

  Widget _buildScenarioSelector() {
    return PopupMenuButton<DashboardScenario>(
      icon: const Icon(Icons.settings_suggest_rounded),
      onSelected: (scenario) => setState(() => _scenario = scenario),
      itemBuilder: (context) => DashboardScenario.values.map((scenario) {
        return PopupMenuItem(
          value: scenario,
          child: Text(scenario.name.toUpperCase()),
        );
      }).toList(),
    );
  }

  Progression _getMockProgression(DashboardScenario scenario) {
    switch (scenario) {
      case DashboardScenario.newUser:
        return Progression.initial();
      case DashboardScenario.maxLevel:
        return const Progression(
          level: 99,
          currentXp: 1000000,
          nextLevelXp: 1000000,
          xpInCurrentLevel: 1000000,
          progressPercentage: 1.0,
          xpRemaining: 0,
          profileCompletion: 1.0,
        );
      case DashboardScenario.returningUser:
        return const Progression(
          level: 42,
          currentXp: 42500,
          nextLevelXp: 50000,
          xpInCurrentLevel: 2500,
          progressPercentage: 0.5,
          xpRemaining: 2500,
          profileCompletion: 0.85,
        );
      default:
        return const Progression(
          level: 10,
          currentXp: 10500,
          nextLevelXp: 15000,
          xpInCurrentLevel: 500,
          progressPercentage: 0.33,
          xpRemaining: 4500,
          profileCompletion: 0.6,
        );
    }
  }
}

class _MockDashboardNotifier extends DashboardNotifier {
  final DashboardScenario scenario;
  _MockDashboardNotifier(this.scenario);

  @override
  DashboardState build() {
    final player = _getMockPlayer();

    switch (scenario) {
      case DashboardScenario.loading:
        return const DashboardState(isLoading: true);
      case DashboardScenario.empty:
        return DashboardState(
          player: player,
          announcements: [],
          dailyChallenge: null,
        );
      case DashboardScenario.error:
        return const DashboardState(error: 'Failed to connect to server');
      case DashboardScenario.offline:
        return const DashboardState(error: 'No internet connection');
      case DashboardScenario.doubleXP:
        return DashboardState(
          player: player,
          announcements: ['Double XP Weekend: Is now live!'],
          dailyChallenge: const DailyChallenge(
            title: 'Double XP Challenge',
            description: 'Complete 5 matches',
            xpReward: 500,
            completionPercentage: 0.2,
          ),
        );
      case DashboardScenario.activeTournament:
        return DashboardState(
          player: player,
          announcements: ['Tournament: Regional Finals starts in 2 days.'],
        );
      case DashboardScenario.newUser:
        return DashboardState(
          player: player,
          announcements: ['Welcome to Soteria: Early Access!'],
        );
      default:
        return DashboardState(
          player: player,
          announcements: [
            'Welcome to Soteria: Early Access!',
            'Double XP Weekend: Is now live!',
          ],
          dailyChallenge: const DailyChallenge(
            title: 'Daily Practice',
            description: 'Level up your skills',
            xpReward: 100,
            completionPercentage: 0.4,
          ),
        );
    }
  }

  dynamic _getMockPlayer() {
    switch (scenario) {
      case DashboardScenario.newUser:
        return MockDataFactory.createNewPlayer();
      case DashboardScenario.maxLevel:
        return MockDataFactory.createExpertPlayer();
      default:
        return MockDataFactory.createMockPlayer();
    }
  }
}
