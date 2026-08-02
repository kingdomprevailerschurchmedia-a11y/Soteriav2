import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/question_content/data/models/question_model.dart';

/// Data source for interacting with Firebase Firestore.
class FirestoreQuestionDataSource {
  final FirebaseFirestore _firestore;

  FirestoreQuestionDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _collectionPath = 'questions';

  /// Fetches questions from Firestore based on filters.
  Future<List<QuestionModel>> fetchQuestions({
    String? category,
    String? topic,
    String? difficulty,
    int limit = 10,
  }) async {
    Query query = _firestore.collection(_collectionPath);

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }
    if (topic != null) {
      query = query.where('topic', isEqualTo: topic);
    }
    if (difficulty != null) {
      query = query.where('difficulty', isEqualTo: difficulty);
    }

    final snapshot = await query.limit(limit).get();

    return snapshot.docs
        .map(
          (doc) => QuestionModel.fromJson(doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  /// Fetches a specific question by ID.
  Future<QuestionModel?> fetchQuestionById(String id) async {
    final doc = await _firestore.collection(_collectionPath).doc(id).get();
    if (!doc.exists) return null;
    return QuestionModel.fromJson(doc.data() as Map<String, dynamic>);
  }
}
