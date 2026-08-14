import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/gameplay_engine/data/repositories/local_gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';

class FakeSharedPreferences implements SharedPreferences {
  final Map<String, dynamic> _data = {};

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late LocalGameplayRepository repository;
  late FakeSharedPreferences fakePrefs;

  setUp(() {
    fakePrefs = FakeSharedPreferences();
    repository = LocalGameplayRepository(fakePrefs);
  });

  final mockState = GameState(
    sessionId: 'session_123',
    lifecycle: GameLifecycle.playing,
    currentQuestionIndex: 2,
    score: 500,
    questions: [
      Question(
        id: 'q1',
        version: '1',
        text: 'Test?',
        difficulty: Difficulty.easy,
        categoryId: 'C',
        type: QuestionType.multipleChoice,
        options: const [
          Answer(id: 'o1', text: 'Ans1'),
          Answer(id: 'o2', text: 'Ans2'),
        ],
        correctOptionIds: const ['o1'],
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
        updatedAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
        source: 'S',
        schemaVersion: 1,
        contentHash: 'H',
      ),
    ],
  );

  group('LocalGameplayRepository Tests', () {
    test('saveSessionState stores JSON in SharedPreferences', () async {
      await repository.saveSessionState(mockState);
      final stored = fakePrefs.getString('active_game_session');
      expect(stored, contains('session_123'));
    });

    test('getActiveSession returns GameState from SharedPreferences', () async {
      await repository.saveSessionState(mockState);
      final result = await repository.getActiveSession();

      expect(result?.sessionId, 'session_123');
      expect(result?.currentQuestionIndex, 2);
    });

    test('clearActiveSession removes key from SharedPreferences', () async {
      await repository.saveSessionState(mockState);
      await repository.clearActiveSession();
      expect(fakePrefs.getString('active_game_session'), isNull);
    });
  });
}
