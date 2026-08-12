import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../../../core/logging/logger_service.dart';
import '../../../player/providers/player_providers.dart';
import '../../domain/models/dashboard_state.dart';
import '../../domain/repositories/home_repository.dart';
import '../../data/repositories/firestore_home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return FirestoreHomeRepository(
    database: ref.watch(firestoreDatabaseServiceProvider),
  );
});

final announcementsProvider = FutureProvider<List<String>>((ref) {
  return ref.watch(homeRepositoryProvider).getAnnouncements();
});

final dailyChallengeProvider = FutureProvider<DailyChallenge?>((ref) {
  return ref.watch(homeRepositoryProvider).getDailyChallenge();
});

class DashboardNotifier extends Notifier<DashboardState> {
  @override
  DashboardState build() {
    final playerAsync = ref.watch(currentPlayerStreamProvider);
    final announcementsAsync = ref.watch(announcementsProvider);
    final challengeAsync = ref.watch(dailyChallengeProvider);

    if (kDebugMode) {
      LoggerService.d(
        'Dashboard State: player=${playerAsync.value != null}, loading=${playerAsync.isLoading}, announcements=${announcementsAsync.value?.length ?? 0}',
        feature: 'Dashboard',
      );
    }

    return DashboardState(
      isLoading: playerAsync.isLoading,
      player: playerAsync.value,
      announcements: announcementsAsync.value ?? const [],
      dailyChallenge: challengeAsync.value,
      error: _getError(playerAsync, announcementsAsync, challengeAsync),
      greeting: _getGreeting(),
    );
  }

  String? _getError(
    AsyncValue player,
    AsyncValue announcements,
    AsyncValue challenge,
  ) {
    if (player.hasError) return player.error.toString();
    if (announcements.hasError) return announcements.error.toString();
    if (challenge.hasError) return challenge.error.toString();
    return null;
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'Good Night';
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  void refresh() {
    ref.invalidate(announcementsProvider);
    ref.invalidate(dailyChallengeProvider);
  }
}

final dashboardProvider = NotifierProvider<DashboardNotifier, DashboardState>(
  DashboardNotifier.new,
);
