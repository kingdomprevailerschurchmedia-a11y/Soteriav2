import '../../domain/models/question.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/repositories/question_repository.dart';
import '../../../question_content/domain/repositories/question_repository.dart' as canonical;

class MockQuestionRepository implements IQuestionRepository, canonical.QuestionRepository {
  final List<Question> _mockQuestions = [
    Question(
      id: 'q1',
      type: QuestionType.multipleChoice,
      categoryId: 'Science',
      difficulty: Difficulty.easy,
      text: 'What is the chemical symbol for water?',
      options: [
        const Answer(id: 'o1', text: 'H2O'),
        const Answer(id: 'o2', text: 'CO2'),
        const Answer(id: 'o3', text: 'O2'),
        const Answer(id: 'o4', text: 'NaCl'),
      ],
      correctOptionIds: ['o1'],
      explanation:
          'Water is composed of two hydrogen atoms and one oxygen atom.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Mock',
    ),
    Question(
      id: 'q2',
      type: QuestionType.multipleChoice,
      categoryId: 'History',
      difficulty: Difficulty.medium,
      text: 'The Great Wall of China is visible from space with the naked eye.',
      options: [
        const Answer(id: 'o1', text: 'True'),
        const Answer(id: 'o2', text: 'False'),
      ],
      correctOptionIds: ['o2'],
      explanation:
          'While an impressive structure, it is not easily visible from space without magnification.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Mock',
    ),
    Question(
      id: 'q3',
      type: QuestionType.multipleChoice,
      categoryId: 'Technology',
      difficulty: Difficulty.hard,
      text: 'Which of the following is NOT a programming language?',
      options: [
        const Answer(id: 'o1', text: 'Python'),
        const Answer(id: 'o2', text: 'Java'),
        const Answer(id: 'o3', text: 'HTML'),
        const Answer(id: 'o4', text: 'C++'),
      ],
      correctOptionIds: ['o3'],
      explanation: 'HTML is a markup language, not a programming language.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Mock',
    ),
    Question(
      id: 'q4',
      type: QuestionType.multipleChoice,
      categoryId: 'Arts',
      difficulty: Difficulty.expert,
      text: 'Who painted the "Starry Night"?',
      options: [
        const Answer(id: 'o1', text: 'Pablo Picasso'),
        const Answer(id: 'o2', text: 'Vincent van Gogh'),
        const Answer(id: 'o3', text: 'Leonardo da Vinci'),
        const Answer(id: 'o4', text: 'Claude Monet'),
      ],
      correctOptionIds: ['o2'],
      explanation: 'Starry Night was painted by Vincent van Gogh in 1889.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      source: 'Mock',
    ),
  ];

  @override
  Future<List<Question>> loadQuestions({
    String? categoryId,
    Difficulty? difficulty,
    bool forceRefresh = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockQuestions.where((q) {
      bool matches = true;
      if (categoryId != null && q.categoryId != categoryId) matches = false;
      if (difficulty != null && q.difficulty != difficulty) matches = false;
      return matches;
    }).toList();
  }

  @override
  Future<List<Question>> loadByCategory(
    String categoryId, {
    bool forceRefresh = false,
  }) => loadQuestions(categoryId: categoryId, forceRefresh: forceRefresh);

  @override
  Future<List<Question>> loadByDifficulty(
    Difficulty difficulty, {
    bool forceRefresh = false,
  }) => loadQuestions(difficulty: difficulty, forceRefresh: forceRefresh);

  @override
  Future<List<Question>> loadRandomQuestions({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final shuffled = List<Question>.from(_mockQuestions)..shuffle();
    return shuffled.take(limit).toList();
  }

  @override
  Future<void> refreshQuestions({
    String? categoryId,
    Difficulty? difficulty,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<Question>> getQuestions({
    String? categoryId,
    String? subcategoryId,
    String? topicId,
    Difficulty? difficulty,
    int limit = 10,
    String? startAfterId,
    List<String>? tags,
  }) async {
    return loadQuestions(categoryId: categoryId, difficulty: difficulty);
  }

  @override
  Future<void> syncQuestionsPool({
    String? categoryId,
    Difficulty? difficulty,
  }) async {}

  @override
  Future<List<Question>> getQuestionsByStatus(QuestionStatus status, {int limit = 50}) async {
    return _mockQuestions;
  }

  @override
  Future<Question?> getQuestionById(String id) async {
    return _mockQuestions.firstWhere((q) => q.id == id);
  }

  @override
  Stream<Question?> watchQuestion(String id) {
    return Stream.value(_mockQuestions.firstWhere((q) => q.id == id));
  }

  @override
  Future<void> clearCache() async {}
}
