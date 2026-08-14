import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/screens/competitive_events_screen.dart';
import '../presentation/screens/competitive_event_details_screen.dart';
import '../presentation/screens/event_result_screen.dart';
import '../presentation/providers/event_providers.dart';
import 'event_fixtures.dart';

class LiveEventPreviews {
  static Widget discovery() {
    return ProviderScope(
      overrides: [
        competitiveEventsProvider.overrideWith(
          (ref) => Stream.value([
            EventFixtures.liveEvent,
            EventFixtures.upcomingEvent,
            EventFixtures.endedEvent,
            EventFixtures.cancelledEvent,
            EventFixtures.lockedEvent,
          ]),
        ),
      ],
      child: const CompetitiveEventsScreen(),
    );
  }

  static Widget details() {
    return ProviderScope(
      overrides: [
        eventDetailsProvider(EventFixtures.liveEvent.eventId).overrideWith(
          (ref) => Stream.value(EventFixtures.liveEvent),
        ),
        eventParticipationProvider(EventFixtures.liveEvent.eventId).overrideWith(
          (ref) => Stream.value(null),
        ),
      ],
      child: CompetitiveEventDetailsScreen(
        eventId: EventFixtures.liveEvent.eventId,
      ),
    );
  }

  static Widget results() {
    return EventResultScreen(
      eventId: EventFixtures.liveEvent.eventId,
      score: 1850,
    );
  }
}
