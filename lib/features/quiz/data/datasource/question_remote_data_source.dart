import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/question.dart';
import '../dto/question_dto.dart';
import '../mapper/question_mapper.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';

abstract interface class IQuestionRemoteDataSource {
  Future<List<Question>> fetchQuestions({
    String? categoryId,
    Difficulty? difficulty,
    int? limit,
  });

  Future<List<Question>> fetchRandomQuestions({int limit = 10});
}

class FirestoreQuestionRemoteDataSource implements IQuestionRemoteDataSource {
  final IDatabaseService _databaseService;

  FirestoreQuestionRemoteDataSource(this._databaseService);

  @override
  Future<List<Question>> fetchQuestions({
    String? categoryId,
    Difficulty? difficulty,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _databaseService.collection(
      'questions',
    );

    if (categoryId != null) {
      query = query.where('category', isEqualTo: categoryId);
    }

    if (difficulty != null) {
      query = query.where('difficulty', isEqualTo: difficulty.name);
    }

    query = query.where('status', isEqualTo: 'active');

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      // Ensure ID is set from document ID if not in data
      if (data['id'] == null) data['id'] = doc.id;
      return QuestionMapper.fromDto(QuestionDto.fromJson(data));
    }).toList();
  }

  @override
  Future<List<Question>> fetchRandomQuestions({int limit = 10}) async {
    // Basic random implementation: fetch a larger set and shuffle
    // For a real production app with millions of questions, we'd use
    // a more scalable random approach (e.g., random index or multiple queries).
    final questions = await fetchQuestions(limit: limit * 5);
    questions.shuffle();
    return questions.take(limit).toList();
  }
}
