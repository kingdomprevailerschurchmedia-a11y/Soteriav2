import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/features/question_content/data/data_sources/firestore_data_source.dart';
import 'package:soteria/features/question_content/data/services/question_import_service.dart';

import 'question_import_service_test.mocks.dart';

@GenerateMocks([FirestoreQuestionDataSource])
void main() {
  late MockFirestoreQuestionDataSource mockDataSource;
  late QuestionImportService service;

  setUp(() {
    mockDataSource = MockFirestoreQuestionDataSource();
    service = QuestionImportService(mockDataSource);
  });

  test('Dry run identifies valid questions and duplicates', () async {
    final json = '''
    [
      {
        "id": "q1",
        "text": "Valid?",
        "difficulty": "easy",
        "categoryId": "gk",
        "type": "multipleChoice",
        "options": [
          { "id": "o1", "text": "A", "displayOrder": 0 },
          { "id": "o2", "text": "B", "displayOrder": 1 }
        ],
        "correctOptionIds": ["o1"],
        "language": "en",
        "estimatedTimeSeconds": 15,
        "xpValue": 10,
        "coinValue": 5,
        "status": "approved",
        "version": "1.0.0",
        "source": "S",
        "createdAt": "2026-08-14T12:00:00Z",
        "updatedAt": "2026-08-14T12:00:00Z",
        "schemaVersion": 1
      },
      {
        "id": "q1",
        "text": "Duplicate?",
        "difficulty": "easy",
        "categoryId": "gk",
        "type": "multipleChoice",
        "options": [{ "id": "o1", "text": "A", "displayOrder": 0 }],
        "correctOptionIds": ["o1"],
        "status": "approved",
        "version": "1.0.0",
        "source": "S",
        "createdAt": "2026-08-14T12:00:00Z",
        "updatedAt": "2026-08-14T12:00:00Z"
      }
    ]
    ''';

    when(mockDataSource.fetchQuestionById("q1")).thenAnswer((_) async => null);

    final result = await service.dryRun(json);

    expect(result.total, 2);
    expect(result.valid, 1);
    expect(result.duplicates, 1);
    expect(result.errors.any((e) => e.contains('Duplicate ID')), true);
  });

  test('Verify first production batch dry run', () async {
    final file = File('tools/question_import/data/first_production_batch_v1.json');
    final json = await file.readAsString();

    when(mockDataSource.fetchQuestionById(any)).thenAnswer((_) async => null);

    final result = await service.dryRun(json);

    print('DRY RUN RESULT:');
    print('Total: ${result.total}');
    print('Valid: ${result.valid}');
    print('Invalid: ${result.invalid}');
    print('Duplicates: ${result.duplicates}');
    
    if (result.errors.isNotEmpty) {
      print('ERRORS:');
      result.errors.forEach(print);
    }

    expect(result.valid, 50);
    expect(result.invalid, 0);
    expect(result.duplicates, 0);
  });
}
