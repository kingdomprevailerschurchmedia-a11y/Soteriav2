import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/live_event.dart';
import '../presentation/providers/live_event_providers.dart';
import '../presentation/screens/live_events_screen.dart';
import '../presentation/screens/live_event_details_screen.dart';

class LiveEventPreviews {
  static List<LiveEvent> mockEvents() {
    final now = DateTime.now();
    return [
      LiveEvent(
        eventId: '1',
        name: 'WEEKEND RUSH',
        description: 'Earn 2x XP in all Versus matches this weekend!',
        status: LiveEventStatus.active,
        startAt: now.subtract(const Duration(hours: 12)),
        endAt: now.add(const Duration(hours: 36)),
        createdAt: now.subtract(const Duration(days: 1)),
        rules: [
          'Play any Versus match',
          'Win to get bonus XP',
          'Valid for all ranks',
        ],
        rewardConfig: {'xp_multiplier': 2.0},
      ),
      LiveEvent(
        eventId: '2',
        name: 'DIAMOND CHALLENGE',
        description: 'Special tournament for top tier players.',
        status: LiveEventStatus.upcoming,
        startAt: now.add(const Duration(days: 2)),
        endAt: now.add(const Duration(days: 4)),
        createdAt: now.subtract(const Duration(days: 1)),
        rules: [
          'Must be Diamond I or higher',
          'Registration ends in 24h',
        ],
        rewardConfig: {'coins': 1000},
      ),
    ];
  }

  static Widget discovery() {
    return ProviderScope(
      overrides: [
        activeLiveEventsProvider.overrideWith(
          (ref) => Stream.value(mockEvents().where((e) => e.status == LiveEventStatus.active).toList()),
        ),
        upcomingLiveEventsProvider.overrideWith(
          (ref) => Future.value(mockEvents().where((e) => e.status == LiveEventStatus.upcoming).toList()),
        ),
      ],
      child: const LiveEventsScreen(),
    );
  }

  static Widget details() {
    final event = mockEvents().first;
    return ProviderScope(
      overrides: [
        eventDetailsProvider(event.eventId).overrideWith(
          (ref) => event,
        ),
      ],
      child: LiveEventDetailsScreen(eventId: event.eventId),
    );
  }
}
