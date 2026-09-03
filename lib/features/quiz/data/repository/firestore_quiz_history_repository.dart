import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/repositories/quiz_history_repository.dart';
import '../../domain/models/question_result.dart';

class FirestoreQuizHistoryRepository implements QuizHistoryRepository {
  final FirebaseFirestore _firestore;

  FirestoreQuizHistoryRepository(this._firestore);

  CollectionReference _resultsRef(String playerId) =>
      _firestore.collection('users').doc(playerId).collection('game_results');

  @override
  Future<void> addResult(QuizResult result) async {
    // Note: Most results are added via FirestorePostGameRepository.syncProgress
    // This implementation ensures compatibility if called directly.
    await _resultsRef(result.playerId).doc(result.sessionId).set(result.toJson());
  }

  @override
  Future<QuizResult?> getResult(String sessionId) async {
    // This requires a collectionGroup query or knowing the playerId.
    // Assuming we use a flattened approach or specific user context.
    // For now, let's assume we fetch from current user if needed, 
    // but the interface doesn't provide playerId for getResult.
    return null; 
  }

  @override
  Future<List<QuizResult>> getResults(String playerId) async {
    final snapshot = await _resultsRef(playerId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => _mapDocToQuizResult(doc)).toList();
  }

  @override
  Future<List<QuizResult>> getRecentResults(
    String playerId, {
    int limit = 10,
  }) async {
    final snapshot = await _resultsRef(playerId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => _mapDocToQuizResult(doc)).toList();
  }

  @override
  Future<List<QuizResult>> getResultsByMode(
    String playerId,
    GameMode mode,
  ) async {
    final snapshot = await _resultsRef(playerId)
        .where('mode', isEqualTo: mode.name)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => _mapDocToQuizResult(doc)).toList();
  }

  @override
  Future<List<QuizResult>> getResultsByCategory(
    String playerId,
    String category,
  ) async {
    final snapshot = await _resultsRef(playerId)
        .where('category', isEqualTo: category)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => _mapDocToQuizResult(doc)).toList();
  }

  @override
  Future<List<QuizResult>> getResultsByDifficulty(
    String playerId,
    Difficulty difficulty,
  ) async {
    final snapshot = await _resultsRef(playerId)
        .where('difficulty', isEqualTo: difficulty.name)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => _mapDocToQuizResult(doc)).toList();
  }

  @override
  Future<List<QuizResult>> getResultsByDateRange(
    String playerId,
    DateTime start,
    DateTime end,
  ) async {
    final snapshot = await _resultsRef(playerId)
        .where('timestamp', isGreaterThanOrEqualTo: start.toIso8601String())
        .where('timestamp', isLessThanOrEqualTo: end.toIso8601String())
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => _mapDocToQuizResult(doc)).toList();
  }

  @override
  Future<List<QuizResult>> getBestResults(
    String playerId, {
    int limit = 5,
  }) async {
    final snapshot = await _resultsRef(playerId)
        .orderBy('finalScore', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => _mapDocToQuizResult(doc)).toList();
  }

  @override
  Future<QuizResult?> getLatestResult(String playerId) async {
    final results = await getRecentResults(playerId, limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  @override
  Future<int> getTotalCompleted(String playerId) async {
    final snapshot = await _resultsRef(playerId).count().get();
    return snapshot.count ?? 0;
  }

  @override
  Future<void> deleteResult(String sessionId) async {
    // Again, needs playerId context in this Firestore structure.
  }

  @override
  Future<void> clearHistory(String playerId) async {
    final batch = _firestore.batch();
    final snapshot = await _resultsRef(playerId).get();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  QuizResult _mapDocToQuizResult(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Mapping from GameResult (saved by FirestorePostGameRepository) to QuizResult
    // GameResult uses 'mode', QuizResult uses 'gameMode'
    // GameResult uses 'timestamp', QuizResult uses 'completedAt'
    
    final completedAtStr = data['timestamp'] as String?;
    final completedAt = completedAtStr != null 
        ? DateTime.parse(completedAtStr) 
        : DateTime.now();

    return QuizResult(
      sessionId: data['sessionId'] ?? doc.id,
      playerId: data['playerId'] ?? '',
      gameMode: _mapMode(data['mode']),
      category: data['category'] ?? 'General',
      difficulty: _mapDifficulty(data['difficulty']),
      totalQuestions: (data['totalQuestions'] as num?)?.toInt() ?? 0,
      answeredQuestions: ((data['correctAnswers'] as num?)?.toInt() ?? 0) + 
                          ((data['wrongAnswers'] as num?)?.toInt() ?? 0),
      correctAnswers: (data['correctAnswers'] as num?)?.toInt() ?? 0,
      wrongAnswers: (data['wrongAnswers'] as num?)?.toInt() ?? 0,
      skipped: (data['skippedQuestions'] as num?)?.toInt() ?? 0,
      timedOut: 0,
      accuracy: (data['accuracy'] as num?)?.toDouble() ?? 0.0,
      finalScore: (data['finalScore'] as num?)?.toInt() ?? 0,
      xpEarned: (data['totalXP'] as num?)?.toInt() ?? 0,
      coinsEarned: (data['rewards']?['totalCoins'] as num?)?.toInt() ?? 0,
      longestStreak: (data['maxStreak'] as num?)?.toInt() ?? 0,
      finalStreak: 0, 
      averageResponseTime: Duration(milliseconds: (data['avgResponseTime'] as num?)?.toInt() ?? 0),
      fastestResponseTime: Duration(milliseconds: (data['fastestAnswerTime'] as num?)?.toInt() ?? 0),
      slowestResponseTime: Duration(milliseconds: (data['slowestAnswerTime'] as num?)?.toInt() ?? 0),
      questionResults: [], // Detailed question results not currently hydrated
      completedAt: completedAt,
      completionTime: Duration(milliseconds: (data['totalDuration'] as num?)?.toInt() ?? 0),
      performanceRating: 'A', // Mock or derived
    );
  }

  GameMode _mapMode(String? modeName) {
    switch (modeName) {
      case 'practice': return GameMode.practice;
      case 'pro': return GameMode.pro;
      case 'versus': return GameMode.versus;
      case 'tournament': return GameMode.tournament;
      default: return GameMode.practice;
    }
  }

  Difficulty _mapDifficulty(String? diffName) {
    switch (diffName) {
      case 'easy': return Difficulty.easy;
      case 'medium': return Difficulty.medium;
      case 'hard': return Difficulty.hard;
      case 'expert': return Difficulty.expert;
      default: return Difficulty.medium;
    }
  }
}
