import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_activity_event.dart';
import '../../domain/repositories/activity_repository.dart';
import '../../data/repositories/firebase_activity_repository.dart';
import '../../../auth/providers/auth_providers.dart';

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return FirebaseActivityRepository(FirebaseFirestore.instance);
});

final recentActivityProvider = StreamProvider<List<CompetitiveActivityEvent>>((
  ref,
) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(activityRepositoryProvider).watchRecentActivity(userId);
});

class ActivityFeedNotifier
    extends StateNotifier<AsyncValue<List<CompetitiveActivityEvent>>> {
  final ActivityRepository _repository;
  final String _userId;
  bool _hasMore = true;
  CompetitiveActivityEvent? _lastEvent;

  ActivityFeedNotifier(this._repository, this._userId)
    : super(const AsyncValue.loading()) {
    loadInitial();
  }

  Future<void> loadInitial() async {
    state = const AsyncValue.loading();
    try {
      final events = await _repository.getActivityEvents(_userId, limit: 20);
      _hasMore = events.length == 20;
      if (events.isNotEmpty) {
        _lastEvent = events.last;
      }
      state = AsyncValue.data(events);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading || state.isRefreshing) return;

    final currentEvents = state.value ?? [];
    try {
      final newEvents = await _repository.getActivityEvents(
        _userId,
        limit: 20,
        lastEvent: _lastEvent,
      );

      _hasMore = newEvents.length == 20;
      if (newEvents.isNotEmpty) {
        _lastEvent = newEvents.last;
      }

      state = AsyncValue.data([...currentEvents, ...newEvents]);
    } catch (e, st) {
      // In a real app we might handle "load more error" without failing the whole list
      state = AsyncValue.error(e, st);
    }
  }

  bool get hasMore => _hasMore;
}

final activityFeedProvider =
    StateNotifierProvider.family<
      ActivityFeedNotifier,
      AsyncValue<List<CompetitiveActivityEvent>>,
      String
    >((ref, userId) {
      return ActivityFeedNotifier(
        ref.watch(activityRepositoryProvider),
        userId,
      );
    });

final currentUserActivityFeedProvider =
    Provider<AsyncValue<List<CompetitiveActivityEvent>>>((ref) {
      final userId = ref.watch(authRepositoryProvider).currentUserId;
      if (userId == null) return const AsyncValue.data([]);
      return ref.watch(activityFeedProvider(userId));
    });
