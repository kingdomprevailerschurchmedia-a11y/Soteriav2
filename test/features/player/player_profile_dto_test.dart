import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/data/models/player_profile_dto.dart';

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  group('PlayerProfileDto', () {
    test('toFirestore should convert profile to map correctly', () {
      final now = DateTime.now();
      final profile = PlayerProfile(
        uid: 'test-uid',
        displayName: 'Test User',
        email: 'test@soteria.com',
        createdAt: now,
        lastLogin: now,
        updatedAt: now,
      );

      final result = PlayerProfileDto.toFirestore(profile);

      expect(result['displayName'], 'Test User');
      expect(result['email'], 'test@soteria.com');
      expect(result['level'], 1);
      expect(result['xp'], 0);
      expect(result['createdAt'], isA<Timestamp>());
    });

    // Note: fromFirestore test would require more complex mocking of DocumentSnapshot
    // but the logic is straightforward DTO mapping.
  });
}
