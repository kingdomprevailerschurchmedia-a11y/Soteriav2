import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../models/question_dto.dart';

/// Data source for interacting with Firebase Firestore for Question Bank.
class FirestoreQuestionDataSource {
  final IDatabaseService _database;

  FirestoreQuestionDataSource(this._database);

  static const String _collectionPath = 'questions';

  /// Fetches questions from Firestore based on filters.
  Future<List<QuestionDto>> fetchQuestions({
    String? categoryId,
    String? subcategoryId,
    String? topicId,
    String? difficulty,
    String? status,
    int limit = 10,
    String? startAfterId,
  }) async {
    Query query = _database.collection(_collectionPath);

    if (status != null) {
      query = query.where('status', isEqualTo: status);
    } else {
      // Default to only published questions for normal users
      query = query.where('status', isEqualTo: 'published');
    }

    if (categoryId != null) {
      query = query.where('categoryId', isEqualTo: categoryId);
    }
    if (subcategoryId != null) {
      query = query.where('subcategoryId', isEqualTo: subcategoryId);
    }
    if (topicId != null) {
      query = query.where('topicId', isEqualTo: topicId);
    }
    if (difficulty != null) {
      query = query.where('difficulty', isEqualTo: difficulty);
    }

    // Ordering for pagination
    query = query.orderBy('createdAt', descending: true);

    if (startAfterId != null) {
      final startAfterDoc = await _database.collection(_collectionPath).doc(startAfterId).get();
      if (startAfterDoc.exists) {
        query = query.startAfterDocument(startAfterDoc);
      }
    }

    final snapshot = await query.limit(limit).get();

    return snapshot.docs
        .map(
          (doc) => QuestionDto.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>}),
        )
        .toList();
  }

  /// Fetches a specific question by ID.
  Future<QuestionDto?> fetchQuestionById(String id) async {
    final doc = await _database.collection(_collectionPath).doc(id).get();
    if (!doc.exists) return null;
    return QuestionDto.fromJson({'id': doc.id, ...doc.data()!});
  }

  /// Watches a question for real-time updates.
  Stream<QuestionDto?> watchQuestion(String id) {
    return _database.collection(_collectionPath).doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;
      return QuestionDto.fromJson({'id': doc.id, ...doc.data()!});
    });
  }

  /// Saves or updates a question in Firestore.
  Future<void> saveQuestion(QuestionDto question) async {
    final data = question.toJson();
    data.remove('id'); // ID is the document ID
    await _database.collection(_collectionPath).doc(question.id).set(data);
  }

  /// Batch saves multiple questions.
  Future<void> saveQuestionsBatch(List<QuestionDto> questions) async {
    // Note: IDatabaseService might not support batch yet, 
    // we'll loop for now or update IDatabaseService if needed.
    for (final q in questions) {
      await saveQuestion(q);
    }
  }
}
