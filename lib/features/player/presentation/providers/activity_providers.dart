import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_activity_event.dart';
import '../../domain/repositories/activity_repository.dart';
import '../../data/repositories/firebase_activity_repository.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../domain/models/competitive_event.dart';

import '../../../social/presentation/providers/social_providers.dart';
import '../../../social/presentation/providers/rivalry_providers.dart';

enum ActivityFilter {
  all,
  friends,
  rivals,
  you,
}

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return FirebaseActivityRepository(FirebaseFirestore.instance);
});

final activityFilterProvider = StateProvider<ActivityFilter>((ref) => ActivityFilter.all);

class ActivityFeedNotifier
    extends StateNotifier<AsyncValue<List<CompetitiveActivityEvent>>> {
  final ActivityRepository _repository;
  final String _userId;
  final ActivityFilter _filter;
  final Ref ref;
  bool _hasMore = true;
  CompetitiveActivityEvent? _lastEvent;

  ActivityFeedNotifier(this._repository, this._userId, this._filter, this.ref)
    : super(const AsyncValue.loading()) {
    loadInitial();
  }

  Future<void> loadInitial() async {
    state = const AsyncValue.loading();
    try {
      final events = await _fetchEvents();
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
      final newEvents = await _fetchEvents(lastEvent: _lastEvent);

      _hasMore = newEvents.length == 20;
      if (newEvents.isNotEmpty) {
        _lastEvent = newEvents.last;
      }

      state = AsyncValue.data([...currentEvents, ...newEvents]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<CompetitiveActivityEvent>> _fetchEvents({
    CompetitiveActivityEvent? lastEvent,
  }) async {
    final friendsAsync = ref.read(friendsProvider);
    final rivalsAsync = ref.read(topRivalriesProvider);
    
    final socialIds = friendsAsync.maybeWhen(
      data: (friends) => friends.map((f) => f.friendId).toList(),
      orElse: () => <String>[],
    );

    final rivalIds = rivalsAsync.maybeWhen(
      data: (rivals) => rivals.map((r) => r.rivalId).toList(),
      orElse: () => <String>[],
    );
    
    final allSocialIds = {...socialIds, ...rivalIds}.toList();
    final allIds = [_userId, ...allSocialIds];
    
    // Fetch aggregated feed from repository
    final allEvents = await _repository.getSocialActivityFeed(
      _userId, 
      allIds,
      limit: 20,
      lastEvent: lastEvent,
    );
    
    if (_filter == ActivityFilter.all) return allEvents;
    if (_filter == ActivityFilter.you) return allEvents.where((e) => e.userId == _userId).toList();
    if (_filter == ActivityFilter.friends) return allEvents.where((e) => socialIds.contains(e.userId)).toList();
    if (_filter == ActivityFilter.rivals) return allEvents.where((e) => rivalIds.contains(e.userId)).toList();
    
    return allEvents;
  }

  bool get hasMore => _hasMore;
}

final activityFeedProvider =
    StateNotifierProvider.family<
      ActivityFeedNotifier,
      AsyncValue<List<CompetitiveActivityEvent>>,
      String
    >((ref, userId) {
      final filter = ref.watch(activityFilterProvider);
      return ActivityFeedNotifier(
        ref.watch(activityRepositoryProvider),
        userId,
        filter,
        ref,
      );
    });

final currentUserActivityFeedProvider =
    Provider<AsyncValue<List<CompetitiveActivityEvent>>>((ref) {
      final userId = ref.watch(authRepositoryProvider).currentUserId;
      if (userId == null) return const AsyncValue.data([]);
      return ref.watch(activityFeedProvider(userId));
    });

final rivalryActivityProvider = FutureProvider.family<List<CompetitiveActivityEvent>, String>((ref, rivalId) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return [];
  
  return ref.watch(activityRepositoryProvider).getSocialActivityFeed(userId, [userId, rivalId], limit: 10);
});
