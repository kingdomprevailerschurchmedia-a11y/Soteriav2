import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soteria/features/gameplay_engine/domain/repositories/gameplay_repository.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';

class LocalGameplayRepository implements GameplayRepository {
  static const String _activeSessionKey = 'active_game_session';
  static const String _resultPrefix = 'game_result_';

  final SharedPreferences _prefs;

  LocalGameplayRepository(this._prefs);

  @override
  Future<void> saveSessionState(GameState state) async {
    final jsonString = jsonEncode(state.toJson());
    await _prefs.setString(_activeSessionKey, jsonString);
  }

  @override
  Future<GameState?> resumeSession(String sessionId) async {
    final jsonString = _prefs.getString(_activeSessionKey);
    if (jsonString == null) return null;

    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    final state = GameState.fromJson(jsonMap);

    if (state.sessionId == sessionId) {
      return state;
    }
    return null;
  }

  @override
  Future<GameState?> getActiveSession() async {
    final jsonString = _prefs.getString(_activeSessionKey);
    if (jsonString == null) return null;

    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return GameState.fromJson(jsonMap);
  }

  @override
  Future<void> clearActiveSession() async {
    await _prefs.remove(_activeSessionKey);
  }

  @override
  Future<void> recordGameResult(GameResult result) async {
    final jsonString = jsonEncode(result.toJson());
    await _prefs.setString('$_resultPrefix${result.sessionId}', jsonString);
  }

  @override
  Future<void> syncSessionMetadata(GameState state) async {
    // Local repository doesn't handle remote sync, but we could track sync status here
  }
}
