import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import '../../../core/firebase/services/firebase_interfaces.dart';

class FakeDatabaseService implements IDatabaseService {
  @override
  firestore.FirebaseFirestore get instance => throw UnimplementedError();

  @override
  firestore.CollectionReference<Map<String, dynamic>> collection(String path) {
    throw UnimplementedError(
      'Collections are mocked per-provider in Preview overrides',
    );
  }

  @override
  firestore.DocumentReference<Map<String, dynamic>> doc(String path) {
    throw UnimplementedError(
      'Documents are mocked per-provider in Preview overrides',
    );
  }

  @override
  Future<void> enablePersistence() async {}
}
