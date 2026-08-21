import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/models/tournament.dart';
import '../../domain/models/tournament_participant.dart';
import '../../domain/models/tournament_ranking.dart';
import '../../domain/models/tournament_raw_result.dart';
import '../../domain/models/tournament_status.dart';
import '../../domain/repositories/tournament_repository.dart';
import '../../logic/tournament_settlement_engine.dart';
import '../models/tournament_dto.dart';
import '../models/tournament_participant_dto.dart';
import '../../../player/domain/repositories/player_progression_repository.dart';
import '../../../player/domain/models/xp_transaction.dart';

class FirestoreTournamentRepository implements TournamentRepository {
  FirestoreTournamentRepository({
    required this._database,
    required this._progressionRepository,
  });

  final IDatabaseService _database;
  final PlayerProgressionRepository _progressionRepository;

  @override
  Future<List<Tournament>> getTournaments() async {
    final snapshot = await _database.collection('tournaments').get();
    return snapshot.docs
        .map((doc) => TournamentDto.fromFirestore(doc))
        .toList();
  }

  @override
  Stream<List<Tournament>> watchTournaments() {
    return _database.collection('tournaments').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => TournamentDto.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Future<Tournament?> getTournament(String id) async {
    final doc = await _database.collection('tournaments').doc(id).get();
    if (!doc.exists) return null;
    return TournamentDto.fromFirestore(doc);
  }

  @override
  Stream<Tournament?> watchTournament(String id) {
    return _database.collection('tournaments').doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;
      return TournamentDto.fromFirestore(doc);
    });
  }

  @override
  Future<void> registerForTournament(
    String tournamentId,
    String uid,
    String displayName,
    String photoUrl,
  ) async {
    final tournamentRef = _database.collection('tournaments').doc(tournamentId);
    final participantRef = tournamentRef.collection('participants').doc(uid);

    await _database.instance.runTransaction((transaction) async {
      final tournamentDoc = await transaction.get(tournamentRef);
      if (!tournamentDoc.exists) throw Exception('Tournament does not exist');

      final data = tournamentDoc.data() as Map<String, dynamic>;
      final maxPlayers = data['maxPlayers'] ?? 0;
      final registeredPlayers = data['registeredPlayers'] ?? 0;
      final status = data['status'] ?? 'upcoming';

      if (status != 'registrationOpen') {
        throw Exception('Registration is not open for this tournament');
      }

      if (registeredPlayers >= maxPlayers) {
        throw Exception('Tournament is full');
      }

      final participantDoc = await transaction.get(participantRef);
      if (participantDoc.exists) throw Exception('User already registered');

      transaction.set(participantRef, {
        'displayName': displayName,
        'photoUrl': photoUrl,
        'registrationTime': FieldValue.serverTimestamp(),
      });

      transaction.update(tournamentRef, {
        'registeredPlayers': FieldValue.increment(1),
      });
    });
  }

  @override
  Future<void> unregisterFromTournament(String tournamentId, String uid) async {
    final tournamentRef = _database.collection('tournaments').doc(tournamentId);
    final participantRef = tournamentRef.collection('participants').doc(uid);

    await _database.instance.runTransaction((transaction) async {
      final participantDoc = await transaction.get(participantRef);
      if (!participantDoc.exists) throw Exception('User not registered');

      transaction.delete(participantRef);

      transaction.update(tournamentRef, {
        'registeredPlayers': FieldValue.increment(-1),
      });
    });
  }

  @override
  Future<bool> isUserRegistered(String tournamentId, String uid) async {
    final doc = await _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('participants')
        .doc(uid)
        .get();
    return doc.exists;
  }

  @override
  Future<List<TournamentParticipant>> getParticipants(
    String tournamentId,
  ) async {
    final snapshot = await _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('participants')
        .get();
    return snapshot.docs
        .map((doc) => TournamentParticipantDto.fromFirestore(doc, tournamentId))
        .toList();
  }

  @override
  Future<void> startTournamentSession(String tournamentId, String uid) async {
    final sessionRef = _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('sessions')
        .doc(uid);

    await _database.instance.runTransaction((transaction) async {
      final doc = await transaction.get(sessionRef);
      if (doc.exists && doc.data()?['status'] == 'playing') {
        throw Exception('A session is already active on another device.');
      }

      transaction.set(sessionRef, {
        'startTime': FieldValue.serverTimestamp(),
        'status': 'playing',
        'currentQuestionIndex': 0,
        'score': 0,
        'lastHeartbeat': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> submitTournamentAnswer(
    String tournamentId,
    String uid,
    String questionId,
    List<String> answerIds,
    Duration responseTime,
  ) async {
    final sessionRef = _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('sessions')
        .doc(uid);

    final answerRef = sessionRef.collection('answers').doc(questionId);

    await _database.instance.runTransaction((transaction) async {
      final answerDoc = await transaction.get(answerRef);
      if (answerDoc.exists) {
        throw Exception('Answer already submitted for this question.');
      }

      // Security: Validate response time window (e.g., must be > 500ms)
      if (responseTime.inMilliseconds < 500) {
        throw Exception('Invalid submission timing detected.');
      }

      transaction.set(answerRef, {
        'answerIds': answerIds,
        'responseTimeMs': responseTime.inMilliseconds,
        'submittedAt': FieldValue.serverTimestamp(),
      });

      // Update heartbeat
      transaction.update(sessionRef, {
        'lastHeartbeat': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> checkpointTournamentProgress(
    String tournamentId,
    String uid,
    int questionIndex,
    int score,
  ) async {
    await _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('sessions')
        .doc(uid)
        .update({
          'currentQuestionIndex': questionIndex,
          'score': score,
          'lastCheckpointAt': FieldValue.serverTimestamp(),
        });
  }

  @override
  Future<void> completeTournamentSession(
    String tournamentId,
    String uid,
    int finalScore,
  ) async {
    await _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('sessions')
        .doc(uid)
        .update({
          'status': 'completed',
          'finalScore': finalScore,
          'completedAt': FieldValue.serverTimestamp(),
        });
  }

  @override
  Future<List<TournamentRanking>> generateLeaderboard(
    String tournamentId,
  ) async {
    // 1. Fetch all completed sessions
    final snapshot = await _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('sessions')
        .where('status', isEqualTo: 'completed')
        .get();

    final List<TournamentRawResult> rawResults = [];
    for (var doc in snapshot.docs) {
      final data = doc.data();
      // Fetch user profile info (simulated for now, usually would be in the session doc)
      // In Story 7.2, we saved basic session info.
      // For ranking, we need accuracy and time.
      rawResults.add(
        TournamentRawResult(
          uid: doc.id,
          displayName: data['displayName'] ?? 'Player',
          photoUrl: data['photoUrl'] ?? '',
          score: data['finalScore'] ?? 0,
          accuracy: data['accuracy'] ?? 0.0,
          completionTime: Duration(milliseconds: data['completionTimeMs'] ?? 0),
          completionTimestamp:
              (data['completedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        ),
      );
    }

    // 2. Use Engine to calculate rankings
    final rankings = TournamentSettlementEngine.calculateFinalRanking(
      rawResults,
    );

    // 3. Persist Top 100 to Firestore
    final batch = _database.instance.batch();
    final leaderboardRef = _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('leaderboard');

    // Clear old leaderboard if exists (optional depending on strategy)

    for (var r in rankings.take(100)) {
      batch.set(leaderboardRef.doc(r.uid), r.toJson());
    }

    await batch.commit();
    return rankings;
  }

  @override
  Future<void> distributeTournamentPrizes(
    String tournamentId,
    List<TournamentRanking> rankings,
  ) async {
    final batch = _database.instance.batch();

    for (var r in rankings) {
      if (r.prize != null && !r.prize!.isEmpty) {
        final playerRef = _database.collection('users').doc(r.uid);
        batch.update(playerRef, {
          'coins': FieldValue.increment(r.prize!.coins),
        });

        // Authoritative XP update
        if (r.prize!.xp > 0) {
          final xpTx = XpTransaction(
            transactionId: '${tournamentId}_${r.uid}_xp',
            userId: r.uid,
            amount: r.prize!.xp,
            source: XpSource.tournament,
            referenceId: tournamentId,
            createdAt: DateTime.now(),
          );
          // Apply separately as it starts its own transaction
          await _progressionRepository.applyXpTransaction(xpTx);
        }

        // Record reward in coin history
        final coinTxRef = _database.collection('coin_transactions').doc();
        batch.set(coinTxRef, {
          'userId': r.uid,
          'type': 'coins',
          'direction': 'credit',
          'amount': r.prize!.coins,
          'source': 'tournamentReward',
          'referenceId': tournamentId,
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
          'metadata': {
            'tournamentId': tournamentId,
            'rank': r.rank,
          },
        });

        // Record reward in history
        final rewardRef = playerRef.collection('rewards').doc();
        batch.set(rewardRef, {
          'type': 'tournament_prize',
          'tournamentId': tournamentId,
          'rank': r.rank,
          'prize': r.prize!.toJson(),
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }

    await batch.commit();
  }

  @override
  Future<void> archiveTournament(String tournamentId) async {
    await _database.collection('tournaments').doc(tournamentId).update({
      'status': TournamentStatus.completed.name,
      'archivedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<TournamentRanking?> getPlayerRanking(
    String tournamentId,
    String uid,
  ) async {
    final doc = await _database
        .collection('tournaments')
        .doc(tournamentId)
        .collection('leaderboard')
        .doc(uid)
        .get();

    if (!doc.exists) return null;
    return TournamentRanking.fromJson(doc.data()!);
  }
}
