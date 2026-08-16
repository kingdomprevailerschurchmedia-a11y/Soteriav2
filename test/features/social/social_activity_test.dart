import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_activity_event.dart';
import 'package:soteria/features/player/domain/models/competitive_event.dart';

void main() {
  group('Social Activity Domain', () {
    test('CompetitiveActivityEvent should include visibility', () {
      final event = CompetitiveActivityEvent(
        id: '1',
        userId: 'u1',
        type: CompetitiveEventType.rankPromoted,
        title: 'Title',
        description: 'Desc',
        createdAt: DateTime(2026),
        visibility: ActivityVisibility.friends,
      );

      expect(event.visibility, ActivityVisibility.friends);
    });

    test('toJson and fromJson should preserve visibility', () {
      final json = {
        'id': '2',
        'userId': 'u1',
        'type': 'achievementUnlocked',
        'title': 'Achieved',
        'description': 'Description',
        'createdAt': '2026-08-16T00:00:00.000Z',
        'visibility': 'friends',
      };

      final event = CompetitiveActivityEvent.fromJson(json);
      expect(event.visibility, ActivityVisibility.friends);
      expect(event.toJson()['visibility'], 'friends');
    });

    test('should support friendshipEstablished event type', () {
      final json = {
        'id': '3',
        'userId': 'u1',
        'type': 'friendshipEstablished',
        'title': 'Connected',
        'description': 'Now friends',
        'createdAt': '2026-08-16T00:00:00.000Z',
        'metadata': {'friendId': 'u2'},
      };

      final event = CompetitiveActivityEvent.fromJson(json);
      expect(event.type, CompetitiveEventType.friendshipEstablished);
      expect(event.metadata['friendId'], 'u2');
    });
  });
}
