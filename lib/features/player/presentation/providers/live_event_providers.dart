import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../data/repositories/firebase_live_event_repository.dart';
import '../../domain/models/live_event.dart';
import '../../domain/repositories/live_event_repository.dart';

final liveEventRepositoryProvider = Provider<LiveEventRepository>((ref) {
  return FirebaseLiveEventRepository(ref.watch(firestoreProvider));
});

final activeLiveEventsProvider = StreamProvider<List<LiveEvent>>((ref) {
  return ref.watch(liveEventRepositoryProvider).watchActiveEvents();
});

final upcomingLiveEventsProvider = FutureProvider<List<LiveEvent>>((ref) {
  return ref.watch(liveEventRepositoryProvider).getUpcomingEvents();
});

final eventDetailsProvider = FutureProvider.family<LiveEvent?, String>((ref, eventId) {
  return ref.watch(liveEventRepositoryProvider).getEvent(eventId);
});
