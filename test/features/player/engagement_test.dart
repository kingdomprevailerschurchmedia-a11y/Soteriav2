import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/services/engagement_service.dart';

void main() {
  late EngagementService service;

  setUp(() {
    service = EngagementService();
  });

  group('EngagementService', () {
    test('getEngagementDate returns correct YYYY-MM-DD string in UTC', () {
      final date = DateTime.utc(2026, 8, 15, 20, 0);
      expect(service.getEngagementDate(date, 'UTC'), '2026-08-15');
    });

    test('isConsecutive returns true for consecutive days', () {
      expect(service.isConsecutive('2026-08-14', '2026-08-15'), true);
    });

    test('isConsecutive returns false for same day', () {
      expect(service.isConsecutive('2026-08-15', '2026-08-15'), false);
    });

    test('isConsecutive returns false for gap of 2 days', () {
      expect(service.isConsecutive('2026-08-13', '2026-08-15'), false);
    });

    test('isSameDay returns true for same date strings', () {
      expect(service.isSameDay('2026-08-15', '2026-08-15'), true);
    });
  });
}
