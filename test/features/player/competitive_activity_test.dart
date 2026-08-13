import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_activity_event.dart';
import 'package:soteria/features/player/domain/models/competitive_event.dart';

void main() {
  group('CompetitiveActivityEvent', () {
    test('should create from JSON correctly', () {
      final json = {
        'id': 'evt_123',
        'userId': 'u1',
        'type': 'rankPromoted',
        'title': 'Promoted!',
        'description': 'Diamond I reached',
        'createdAt': '2026-08-11T12:00:00.000Z',
        'seasonId': 's5',
        'metadata': {'rank': 'Diamond I'},
        'deepLink': 'profile',
        'importance': 'high',
      };

      final event = CompetitiveActivityEvent.fromJson(json);

      expect(event.id, 'evt_123');
      expect(event.type, CompetitiveEventType.rankPromoted);
      expect(event.importance, ActivityImportance.high);
      expect(event.createdAt.isUtc, isTrue);
    });

    test('should handle importance mapping correctly', () {
      expect(ActivityImportance.values[0], ActivityImportance.low);
      expect(ActivityImportance.values[1], ActivityImportance.normal);
      expect(ActivityImportance.values[2], ActivityImportance.high);
      expect(ActivityImportance.values[3], ActivityImportance.milestone);
    });

    test('should support new activity types', () {
      final streakJson = {
        'id': 'streak_10',
        'userId': 'u1',
        'type': 'streakReached',
        'title': '10 Win Streak!',
        'description': 'Unstoppable!',
        'createdAt': DateTime.now().toIso8601String(),
        'metadata': {'streak': 10},
        'importance': 'high',
      };

      final event = CompetitiveActivityEvent.fromJson(streakJson);
      expect(event.type, CompetitiveEventType.streakReached);
    });
  });
}
