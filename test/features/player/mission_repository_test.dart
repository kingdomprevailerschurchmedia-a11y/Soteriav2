import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/data/repositories/firebase_mission_repository.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';

@GenerateMocks([FirebaseFirestore, CollectionReference, DocumentReference, QuerySnapshot, QueryDocumentSnapshot, DocumentSnapshot])
import 'mission_repository_test.mocks.dart';

void main() {
  late FirebaseMissionRepository repository;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    repository = FirebaseMissionRepository(mockFirestore);
  });

  group('FirebaseMissionRepository', () {
    test('getMissionDefinitions should return deterministic list', () async {
      final definitions = await repository.getMissionDefinitions();
      expect(definitions, isNotEmpty);
      expect(definitions.any((d) => d.period == MissionPeriod.daily), true);
      expect(definitions.any((d) => d.period == MissionPeriod.weekly), true);
    });
  });
}
