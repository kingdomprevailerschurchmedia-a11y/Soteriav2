import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> startCompetitiveSession(String sessionId, String uid) async {
    final sessionRef = _database.collection('competitive_sessions').doc(sessionId);
    
    await _database.instance.runTransaction<void>((transaction) async {
      final sessionDoc = await transaction.get(sessionRef);
      
      if (!sessionDoc.exists) {
        throw Exception('Session not found.');
      }
      
      final data = sessionDoc.data() as Map<String, dynamic>;
      
      // Ownership Validation
      if (data['uid'] != uid) {
        throw Exception('Security violation: Session ownership mismatch.');
      }
      
      // Lifecycle Validation
      if (data['status'] != 'initialized') {
        // If already active, it might be a retry, which is acceptable but shouldn't re-init
        if (data['status'] == 'active') return;
        throw Exception('Invalid session state for activation: ${data['status']}');
      }
      
      final now = DateTime.now();
      transaction.update(sessionRef, {
        'status': 'active',
        'startedAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
        'lastHeartbeatAt': now.toIso8601String(),
      });
    });
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
    final now = DateTime.now();
    await _database.collection('competitive_sessions').doc(sessionId).update({
      'lastQuestionIndex': state.currentQuestionIndex,
      'currentScore': state.score,
      'updatedAt': now.toIso8601String(),
      'lastHeartbeatAt': now.toIso8601String(),
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
