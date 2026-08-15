import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/models/live_event.dart';
import '../../domain/models/event_participation.dart';
import '../../domain/repositories/event_repository.dart';
import '../../data/repositories/firebase_event_repository.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../domain/models/leaderboard_entry.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../providers/leaderboard_providers.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return FirebaseEventRepository(ref.watch(firestoreProvider));
});

final eventLeaderboardProvider = FutureProvider.family<List<LeaderboardEntry>, String>((ref, eventId) async {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return repository.getLeaderboardPage(seasonId: eventId, limit: 100);
});

final competitiveEventsProvider = StreamProvider<List<LiveEvent>>((ref) {
  return ref.watch(eventRepositoryProvider).watchEvents();
});

final liveEventsProvider = Provider<AsyncValue<List<LiveEvent>>>((ref) {
  return ref.watch(competitiveEventsProvider).whenData(
    (events) => events.where((e) => e.status == LiveEventStatus.live).toList(),
  );
});

final upcomingEventsProvider = Provider<AsyncValue<List<LiveEvent>>>((ref) {
  return ref.watch(competitiveEventsProvider).whenData(
    (events) => events.where((e) => e.status == LiveEventStatus.upcoming).toList(),
  );
});

final eventDetailsProvider = StreamProvider.family<LiveEvent?, String>((ref, eventId) {
  return ref.watch(eventRepositoryProvider).watchEvent(eventId);
});

final eventParticipationProvider = StreamProvider.family<EventParticipation?, String>((ref, eventId) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value(null);
  return ref.watch(eventRepositoryProvider).watchParticipation(eventId, userId);
});

final eventEligibilityProvider = FutureProvider.family<bool, String>((ref, eventId) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Future.value(false);
  return ref.watch(eventRepositoryProvider).checkEligibility(eventId, userId);
});

final eventHistoryProvider = StreamProvider<List<EventParticipation>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(eventRepositoryProvider).watchUserHistory(userId);
});

class EventController extends StateNotifier<AsyncValue<void>> {
  EventController(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> joinEvent(String eventId) async {
    state = const AsyncValue.loading();
    try {
      final userId = ref.read(authRepositoryProvider).currentUserId;
      if (userId == null) throw Exception('User not authenticated');
      await ref.read(eventRepositoryProvider).joinEvent(eventId, userId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> startSession(String eventId) async {
    state = const AsyncValue.loading();
    try {
      final userId = ref.read(authRepositoryProvider).currentUserId;
      if (userId == null) throw Exception('User not authenticated');
      await ref.read(eventRepositoryProvider).startEventSession(eventId, userId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> submitScore(String eventId, int score) async {
    state = const AsyncValue.loading();
    try {
      final userId = ref.read(authRepositoryProvider).currentUserId;
      if (userId == null) throw Exception('User not authenticated');
      await ref.read(eventRepositoryProvider).submitEventScore(eventId, userId, score);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final eventControllerProvider = StateNotifierProvider<EventController, AsyncValue<void>>((ref) {
  return EventController(ref);
});
