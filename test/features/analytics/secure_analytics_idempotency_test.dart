import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/features/analytics/data/repositories/firestore_question_analytics_repository.dart';
import 'package:soteria/features/quiz/domain/models/question_result.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

import 'secure_analytics_idempotency_test.mocks.dart';

@GenerateMocks([IDatabaseService, CollectionReference, DocumentReference, DocumentSnapshot])
void main() {
  late FirestoreQuestionAnalyticsRepository repository;
  late MockIDatabaseService mockDatabase;
  late MockCollectionReference<Map<String, dynamic>> mockCollection;
  late MockDocumentReference<Map<String, dynamic>> mockDocRef;

  setUp(() {
    mockDatabase = MockIDatabaseService();
    mockCollection = MockCollectionReference();
    mockDocRef = MockDocumentReference();

    when(mockDatabase.collection('question_analytics_events')).thenReturn(mockCollection);
    when(mockCollection.doc(any)).thenReturn(mockDocRef);

    repository = FirestoreQuestionAnalyticsRepository(mockDatabase);
  });

  group('Secure Analytics Idempotency', () {
    test('recordEvent uses deterministic ID: sessionId_questionId', () async {
      final result = QuestionResult(
        questionId: 'q123',
        questionNumber: 1,
        questionText: 'Test',
        outcome: QuestionOutcome.correct,
        correctOptionIds: ['o1'],
        correctOptionText: 'Ans',
        responseTime: const Duration(seconds: 5),
        scoreEarned: 100,
        questionVersion: '1.0.0',
      );

      final sessionId = 'session_abc';
      final userId = 'user_999';

      await repository.recordEvent(sessionId, userId, result);

      // Verify deterministic ID
      verify(mockCollection.doc('session_abc_q123')).called(1);
      verify(mockDocRef.set(any)).called(1);
    });

    test('Duplicate recording results in the same document ID (Firestore idempotency)', () async {
      final result = QuestionResult(
        questionId: 'q123',
        questionNumber: 1,
        questionText: 'Test',
        outcome: QuestionOutcome.correct,
        correctOptionIds: ['o1'],
        correctOptionText: 'Ans',
        responseTime: const Duration(seconds: 5),
        scoreEarned: 100,
        questionVersion: '1.0.0',
      );

      final sessionId = 'session_abc';
      final userId = 'user_999';

      // First call
      await repository.recordEvent(sessionId, userId, result);
      // Retry call
      await repository.recordEvent(sessionId, userId, result);

      // Both calls should target the same document path
      verify(mockCollection.doc('session_abc_q123')).called(2);
      // In Firestore, set() with same ID is idempotent at the data level
    });
  });
}
