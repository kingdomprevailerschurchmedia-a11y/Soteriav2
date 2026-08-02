import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../player/providers/player_providers.dart';
import '../../domain/models/dashboard_state.dart';
import '../../domain/repositories/home_repository.dart';
import '../../data/repositories/mock_home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return MockHomeRepository();
});

class DashboardNotifier extends Notifier<DashboardState> {
  @override
  DashboardState build() {
    final player = ref.watch(currentPlayerProvider);

    // Trigger initial fetch
    Future.microtask(() => _fetchHomeData());

    return DashboardState(
      isLoading: true,
      player: player,
      greeting: _getGreeting(),
    );
  }

  Future<void> _fetchHomeData() async {
    final repo = ref.read(homeRepositoryProvider);

    try {
      final announcements = await repo.getAnnouncements();
      final dailyChallenge = await repo.getDailyChallenge();

      if (ref.mounted) {
        state = state.copyWith(
          isLoading: false,
          announcements: announcements,
          dailyChallenge: dailyChallenge,
        );
      }
    } catch (e) {
      if (ref.mounted) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  void refresh() => _fetchHomeData();
}

final dashboardProvider = NotifierProvider<DashboardNotifier, DashboardState>(
  DashboardNotifier.new,
);
