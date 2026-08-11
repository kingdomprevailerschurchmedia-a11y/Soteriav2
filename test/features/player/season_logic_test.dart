import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_season.dart';
import 'package:soteria/features/player/domain/models/season_countdown.dart';

void main() {
  group('CompetitiveSeason - Status Calculation', () {
    final start = DateTime(2026, 8, 1);
    final end = DateTime(2026, 8, 31);

    final season = CompetitiveSeason(
      seasonId: 's1',
      name: 'Test Season',
      status: SeasonStatus.active,
      startAt: start,
      endAt: end,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('should return UPCOMING if now is before startAt', () {
      final now = start.subtract(const Duration(seconds: 1));
      expect(season.calculateStatus(now), SeasonStatus.upcoming);
    });

    test('should return COMPLETED if now is after endAt', () {
      final now = end.add(const Duration(seconds: 1));
      expect(season.calculateStatus(now), SeasonStatus.completed);
    });

    test('should return ENDING if within 24h of endAt', () {
      final now = end.subtract(const Duration(hours: 12));
      expect(season.calculateStatus(now), SeasonStatus.ending);
    });

    test('should return ACTIVE if between startAt and ending threshold', () {
      final now = start.add(const Duration(days: 1));
      expect(season.calculateStatus(now), SeasonStatus.active);
    });
  });

  group('SeasonCountdown - Logic', () {
    test('should format duration correctly into parts', () {
      const duration = Duration(days: 2, hours: 3, minutes: 15, seconds: 45);
      final countdown = SeasonCountdown.fromDuration(duration);

      expect(countdown.days, 2);
      expect(countdown.hours, 3);
      expect(countdown.minutes, 15);
      expect(countdown.seconds, 45);
      expect(countdown.status, CountdownStatus.active);
    });

    test('should set status to ENDING_SOON if below 24h', () {
      const duration = Duration(hours: 23);
      final countdown = SeasonCountdown.fromDuration(duration);
      expect(countdown.status, CountdownStatus.endingSoon);
    });

    test('should set status to ENDED if duration is zero or negative', () {
      final countdown = SeasonCountdown.fromDuration(Duration.zero);
      expect(countdown.status, CountdownStatus.ended);
    });
  });
}
