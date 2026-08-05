import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/competitive_stats_repository.dart';
import '../../models/game_result.dart';

class FirestoreCompetitiveStatsRepository
    implements CompetitiveStatsRepository {
  final IDatabaseService _database;

  FirestoreCompetitiveStatsRepository(this._database);

  @override
  Future<void> updatePlayerStats(
    String uid,
    GameResult result,
    int coinsDelta,
  ) async {
    final playerDoc = _database.collection('players').doc(uid);

    await playerDoc.update({
      'totalQuestionsAnswered': FieldValue.increment(result.totalQuestions),
      'correctAnswers': FieldValue.increment(result.correctAnswers),
      'gamesPlayed': FieldValue.increment(1),
      if (result.accuracy >= 0.7) 'gamesWon': FieldValue.increment(1),
      'coinsWon': FieldValue.increment(coinsDelta > 0 ? coinsDelta : 0),
      'coinsLost': FieldValue.increment(coinsDelta < 0 ? -coinsDelta : 0),
      // Recalculate accuracy on read or update here if needed
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }
}
