import '../domain/models/live_event.dart';
import '../domain/models/event_participation.dart';

class EventFixtures {
  static final liveEvent = LiveEvent(
    eventId: 'weekend_rush_1',
    title: 'Weekend Rush',
    description:
        'Answer 20 questions as fast as you can. Top players win exclusive badges!',
    status: LiveEventStatus.live,
    startAt: DateTime.now().subtract(const Duration(hours: 1)),
    endAt: DateTime.now().add(const Duration(hours: 3)),
    category: 'mathematics',
    rules: [
      '20 Questions',
      '15 Seconds per question',
      '1 Attempt only',
      'Rank-based rewards',
    ],
    rewardConfiguration: {
      'xp': 500,
      'coins': 100,
    },
    participantCount: 1250,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  );

  static final upcomingEvent = liveEvent.copyWith(
    eventId: 'category_clash_1',
    title: 'Category Clash: Science',
    status: LiveEventStatus.upcoming,
    startAt: DateTime.now().add(const Duration(days: 1)),
    endAt: DateTime.now().add(const Duration(days: 1, hours: 2)),
    participantCount: 0,
  );

  static final endedEvent = liveEvent.copyWith(
    eventId: 'history_hunt_1',
    title: 'History Hunt',
    status: LiveEventStatus.ended,
    startAt: DateTime.now().subtract(const Duration(days: 2)),
    endAt: DateTime.now().subtract(const Duration(days: 2, hours: -1)),
  );

  static final cancelledEvent = liveEvent.copyWith(
    eventId: 'sports_showdown_1',
    title: 'Sports Showdown',
    status: LiveEventStatus.cancelled,
    description: 'This event has been cancelled due to technical maintenance.',
  );

  static final lockedEvent = liveEvent.copyWith(
    eventId: 'grand_master_only',
    title: 'Grand Master Invitational',
    status: LiveEventStatus.locked,
    description: 'Reach Grand Master rank to unlock this elite event.',
  );

  static final participation = EventParticipation(
    eventId: 'weekend_rush_1',
    userId: 'user_123',
    status: ParticipationStatus.joined,
    joinedAt: DateTime.now().subtract(const Duration(minutes: 30)),
  );

  static final completedParticipation = participation.copyWith(
    status: ParticipationStatus.completed,
    score: 1850,
    rank: 4,
    completedAt: DateTime.now().subtract(const Duration(minutes: 5)),
  );
}
