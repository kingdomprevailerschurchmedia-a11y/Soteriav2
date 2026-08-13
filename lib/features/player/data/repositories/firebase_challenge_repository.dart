import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_challenge.dart';
import '../../domain/repositories/challenge_repository.dart';
import '../../../gameplay_engine/models/versus_match.dart';
import 'package:uuid/uuid.dart';

class FirebaseChallengeRepository implements ChallengeRepository {
  final FirebaseFirestore _firestore;

  FirebaseChallengeRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _challenges =>
      _firestore.collection('challenges');

  CollectionReference<Map<String, dynamic>> get _matches =>
      _firestore.collection('versus_matches');

  @override
  Future<void> sendChallenge(CompetitiveChallenge challenge) async {
    await _challenges.doc(challenge.challengeId).set(challenge.toJson());
  }

  @override
  Future<void> acceptChallenge(String challengeId) async {
    await _firestore.runTransaction((transaction) async {
      final challengeDoc = _challenges.doc(challengeId);
      final snapshot = await transaction.get(challengeDoc);

      if (!snapshot.exists) throw Exception('Challenge not found');
      
      final challenge = CompetitiveChallenge.fromJson(snapshot.data()!);
      
      if (challenge.status != ChallengeStatus.pending) {
        throw Exception('Challenge is no longer pending');
      }

      if (challenge.expiresAt.isBefore(DateTime.now())) {
        transaction.update(challengeDoc, {'status': 'expired'});
        throw Exception('Challenge has expired');
      }

      final matchId = const Uuid().v4();
      final match = VersusMatch(
        matchId: matchId,
        playerAId: challenge.challengerId,
        playerBId: challenge.challengedPlayerId,
        status: MatchStatus.created,
        createdAt: DateTime.now(),
        mode: challenge.mode,
        configuration: challenge.configuration,
      );

      transaction.update(challengeDoc, {
        'status': 'accepted',
        'matchId': matchId,
      });

      transaction.set(_matches.doc(matchId), match.toJson());
    });
  }

  @override
  Future<void> declineChallenge(String challengeId) async {
    await _challenges.doc(challengeId).update({
      'status': 'declined',
    });
  }

  @override
  Future<void> cancelChallenge(String challengeId) async {
    await _challenges.doc(challengeId).update({
      'status': 'cancelled',
    });
  }

  @override
  Stream<List<CompetitiveChallenge>> watchIncomingChallenges(String userId) {
    return _challenges
        .where('challengedPlayerId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CompetitiveChallenge.fromJson(doc.data()))
            .toList());
  }

  @override
  Stream<List<CompetitiveChallenge>> watchOutgoingChallenges(String userId) {
    return _challenges
        .where('challengerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CompetitiveChallenge.fromJson(doc.data()))
            .toList());
  }

  @override
  Future<CompetitiveChallenge?> getChallenge(String challengeId) async {
    final doc = await _challenges.doc(challengeId).get();
    if (!doc.exists) return null;
    return CompetitiveChallenge.fromJson(doc.data()!);
  }
}
