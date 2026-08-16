import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/live_event.dart';

void main() {
  group('LiveEvent Status Logic', () {
    final start = DateTime(2026, 8, 14, 10);
    final end = DateTime(2026, 8, 14, 20); // 10 hour duration

    final event = LiveEvent(
      eventId: 'e1',
      title: 'Test Event',
      description: 'Desc',
      status: LiveEventStatus.live,
      startAt: start,
      endAt: end,
      category: 'math',
      rules: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('should return UPCOMING if now is before startAt', () {
      final now = start.subtract(const Duration(minutes: 1));
      expect(event.calculateStatus(now), LiveEventStatus.upcoming);
    });

    test('should return ENDED if now is after endAt', () {
      final now = end.add(const Duration(minutes: 1));
      expect(event.calculateStatus(now), LiveEventStatus.ended);
    });

    test('should return ENDING if within 4h of endAt', () {
      final now = end.subtract(const Duration(hours: 1));
      expect(event.calculateStatus(now), LiveEventStatus.ending);
    });

    test('should return LIVE if between startAt and ending threshold', () {
      final now = start.add(const Duration(minutes: 1));
      expect(event.calculateStatus(now), LiveEventStatus.live);
    });

    test('should respect CANCELLED status regardless of time', () {
      final cancelled = event.copyWith(status: LiveEventStatus.cancelled);
      expect(
        cancelled.calculateStatus(start.add(const Duration(minutes: 1))),
        LiveEventStatus.cancelled,
      );
    });
  });
}
