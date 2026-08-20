import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/competitive_repository.dart';
import '../../models/game_state.dart';
import '../../models/game_result.dart';

class FirestoreCompetitiveRepository implements CompetitiveRepository {
  final IDatabaseService _database;

  FirestoreCompetitiveRepository(this._database);

  @override
  Future<void> submitCompetitiveAnswer(String sessionId, dynamic answer) async {
    // Pro Mode answer submission might include more verification data
    await _database
        .collection('competitive_sessions')
        .doc(sessionId)
        .collection('answers')
        .add(answer);
  }

  @override
  Future<void> startCompetitiveSession(String sessionId) async {
    await _database.collection('competitive_sessions').doc(sessionId).set({
      'status': 'active',
      'startedAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> updateSessionCheckpoint(
    String sessionId,
    GameState state,
  ) async {
    await _database
        .collection('competitive_sessions')
        .doc(sessionId)
        .collection('checkpoints')
        .add({
          'state': state.toJson(),
          'timestamp': DateTime.now().toIso8601String(),
          'checkpointId': 'cp_${state.currentQuestionIndex}',
        });

    // Update main session doc with last known state for recovery
    await _database.collection('competitive_sessions').doc(sessionId).update({
      'lastQuestionIndex': state.currentQuestionIndex,
      'currentScore': state.score,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<bool> validateCheckpoint(String sessionId, String checkpointId) async {
    // In a real implementation, this would involve verifying hashes
    return true;
  }

  @override
  Future<void> completeCompetitiveSession(
    String sessionId,
    GameResult result,
  ) async {
    await _database.collection('competitive_sessions').doc(sessionId).update({
      'status': 'completed',
      'finalResult': result.toJson(),
      'completedAt': DateTime.now().toIso8601String(),
    });
  }
}
