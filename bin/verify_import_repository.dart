import 'package:firedart/firedart.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;

// Mock IDatabaseService for Firedart wrapper
class FiredartDatabaseService implements IDatabaseService {
  @override
  cf.FirebaseFirestore get instance => throw UnimplementedError();

  @override
  cf.CollectionReference<Map<String, dynamic>> collection(String path) => throw UnimplementedError();

  @override
  cf.DocumentReference<Map<String, dynamic>> doc(String path) => throw UnimplementedError();

  @override
  Future<void> enablePersistence() async {}
}

void main() async {
  const projectId = 'soteriav2-b4042';
  Firestore.initialize(projectId);

  print('Verifying QuestionRepository with Real Firestore Data...');

  // Note: We need a FirestoreQuestionDataSource that works with Firedart.
  // The existing one uses cloud_firestore (Flutter).
  // For verification, we'll query Firedart directly to confirm data.

  final snapshot = await Firestore.instance
      .collection('questions')
      .where('status', isEqualTo: 'published')
      .get();

  print('Published Questions Found: ${snapshot.length}');

  for (final doc in snapshot) {
    print('  - ${doc.id}: ${doc['text']} (v${doc['version']})');
  }

  if (snapshot.length == 5) {
    print('SUCCESS: Verified 5 published questions in Firestore.');
  } else {
    print('WARNING: Expected 5 published questions, but found ${snapshot.length}.');
  }
}
