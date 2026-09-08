import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../../../core/logging/logger_service.dart';
import '../../../quiz/domain/models/quiz_enums.dart';
import '../../domain/models/question_analytics.dart';
import '../../domain/models/question_analytics_event.dart';
import '../../domain/repositories/question_analytics_repository.dart';
import '../../../quiz/domain/models/question_result.dart';

class FirestoreQuestionAnalyticsRepository implements QuestionAnalyticsRepository {
  final IDatabaseService _database;

  FirestoreQuestionAnalyticsRepository(this._database);

  @override
  Future<void> recordEvent(String sessionId, String userId, QuestionResult result) async {
    final event = QuestionAnalyticsEvent.fromResult(
      sessionId: sessionId,
      userId: userId,
      result: result,
    );

    // Use deterministic ID for idempotency: sessionId_questionId
    await _database.collection('question_analytics_events')
        .doc(event.eventId)
        .set(event.toJson());
  }

  @override
  Future<void> recordEvents(String sessionId, String userId, List<QuestionResult> results) async {
    if (results.isEmpty) return;

    final batch = _database.instance.batch();
    final collection = _database.collection('question_analytics_events');

    for (final result in results) {
      final event = QuestionAnalyticsEvent.fromResult(
        sessionId: sessionId,
        userId: userId,
        result: result,
      );
      final docRef = collection.doc(event.eventId);
      batch.set(docRef, event.toJson());
    }

    await batch.commit();
  }

  @override
  Future<Set<String>> getRecentlyAnsweredIds(String userId, {Duration? within}) async {
    final cutoff = DateTime.now().subtract(within ?? const Duration(days: 14));
    
    try {
      final snapshot = await _database.collection('question_analytics_events')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThan: cutoff)
          .get();

      return snapshot.docs.map((doc) => doc.data()['questionId'] as String).toSet();
    } catch (e) {
      LoggerService.e('Failed to fetch recently answered IDs', error: e, feature: 'Analytics');
      return {};
    }
  }

  @override
  Future<QuestionAnalytics?> getQuestionAnalytics(String questionId, String version) async {
    final docId = _getDocId(questionId, version);
    final snapshot = await _database.collection('question_performance').doc(docId).get();
    
    if (!snapshot.exists || snapshot.data() == null) return null;
    return QuestionAnalytics.fromJson(snapshot.data()!);
  }

  @override
  Future<List<QuestionAnalytics>> getQuestionVersionHistory(String questionId) async {
    final snapshot = await _database.collection('question_performance')
        .where('questionId', isEqualTo: questionId)
        .get();
        
    return snapshot.docs.map((d) => QuestionAnalytics.fromJson(d.data())).toList();
  }

  @override
  Future<void> updateMetrics(QuestionResult result) async {
    // This remains as an administrative/internal path.
    // It should not be called directly by the mobile client in production
    // if the user is not an Admin.
    final version = result.questionVersion ?? '1.0.0';
    final docId = _getDocId(result.questionId, version);
    final ref = _database.collection('question_performance').doc(docId);

    final isCorrect = result.outcome == QuestionOutcome.correct;
    final isIncorrect = result.outcome == QuestionOutcome.incorrect;
    final isTimeout = result.outcome == QuestionOutcome.timedOut;
    final isSkipped = result.outcome == QuestionOutcome.skipped;
    
    final responseTimeMs = result.responseTime.inMilliseconds;
    final modeKey = result.mode?.toString().split('.').last ?? GameMode.practice.toString().split('.').last;

    await _database.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      
      if (!snapshot.exists) {
        final analytics = {
          'questionId': result.questionId,
          'version': version,
          'categoryId': result.categoryId ?? 'unknown',
          'difficulty': result.difficulty?.toString().split('.').last ?? Difficulty.medium.toString().split('.').last,
          'totalAttempts': 1,
          'correctAttempts': isCorrect ? 1 : 0,
          'incorrectAttempts': isIncorrect ? 1 : 0,
          'timeoutCount': isTimeout ? 1 : 0,
          'skipCount': isSkipped ? 1 : 0,
          'averageResponseTime': responseTimeMs,
          'fastestResponseTime': responseTimeMs,
          'slowestResponseTime': responseTimeMs,
          'firstAttemptAt': FieldValue.serverTimestamp(),
          'lastAttemptAt': FieldValue.serverTimestamp(),
          'modeBreakdown': {modeKey: 1},
        };
        transaction.set(ref, analytics);
      } else {
        final data = snapshot.data()!;
        final int total = (data['totalAttempts'] ?? 0) + 1;
        
        final int oldAvg = data['averageResponseTime'] ?? 0;
        final int newAvg = ((oldAvg * (total - 1)) + responseTimeMs) ~/ total;
        
        final int fastest = data['fastestResponseTime'] ?? responseTimeMs;
        final int slowest = data['slowestResponseTime'] ?? responseTimeMs;

        final updates = {
          'totalAttempts': FieldValue.increment(1),
          'correctAttempts': FieldValue.increment(isCorrect ? 1 : 0),
          'incorrectAttempts': FieldValue.increment(isIncorrect ? 1 : 0),
          'timeoutCount': FieldValue.increment(isTimeout ? 1 : 0),
          'skipCount': FieldValue.increment(isSkipped ? 1 : 0),
          'averageResponseTime': newAvg,
          'fastestResponseTime': responseTimeMs > 0 && responseTimeMs < fastest ? responseTimeMs : fastest,
          'slowestResponseTime': responseTimeMs > slowest ? responseTimeMs : slowest,
          'lastAttemptAt': FieldValue.serverTimestamp(),
          'modeBreakdown.$modeKey': FieldValue.increment(1),
          'categoryId': result.categoryId ?? data['categoryId'],
          'difficulty': result.difficulty?.toString().split('.').last ?? data['difficulty'],
        };
        
        transaction.update(ref, updates);
      }
    });
  }

  @override
  Future<List<QuestionAnalytics>> getReviewSignals({
    double lowAccuracyThreshold = 0.3,
    double highAccuracyThreshold = 0.95,
  }) async {
    final snapshot = await _database.collection('question_performance').get();
    
    return snapshot.docs
        .map((d) => QuestionAnalytics.fromJson(d.data()))
        .where((a) {
          final level = a.qualityLevel;
          return level == QualitySignalLevel.reviewRecommended || 
                 level == QualitySignalLevel.qualitySignal;
        })
        .toList();
  }

  String _getDocId(String questionId, String version) {
    return '${questionId}_v${version.replaceAll('.', '_')}';
  }
}
