import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_challenge.dart';
import '../../domain/repositories/challenge_repository.dart';

class FirebaseChallengeRepository implements ChallengeRepository {
  final FirebaseFirestore _firestore;

  FirebaseChallengeRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _challenges =>
      _firestore.collection('challenges');

  @override
  Future<void> sendChallenge(CompetitiveChallenge challenge) async {
    await _challenges.doc(challenge.challengeId).set(challenge.toJson());
  }

  @override
  Future<void> acceptChallenge(String challengeId) async {
    await _challenges.doc(challengeId).update({
      'status': ChallengeStatus.active.name,
      'startAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> declineChallenge(String challengeId) async {
    await _challenges.doc(challengeId).update({
      'status': ChallengeStatus.declined.name,
    });
  }

  @override
  Future<void> cancelChallenge(String challengeId) async {
    await _challenges.doc(challengeId).update({
      'status': ChallengeStatus.cancelled.name,
    });
  }

  @override
  Stream<List<CompetitiveChallenge>> watchIncomingChallenges(String userId) {
    return _challenges
        .where('challengedPlayerId', isEqualTo: userId)
        .where('status', isEqualTo: ChallengeStatus.pending.name)
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
        .where('status', isEqualTo: ChallengeStatus.pending.name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CompetitiveChallenge.fromJson(doc.data()))
            .toList());
  }

  @override
  Stream<List<CompetitiveChallenge>> watchActiveChallenges(String userId) {
    // Challenges where the user is either challenger or opponent and status is active
    return _firestore.collectionGroup('challenges') 
        .where('status', isEqualTo: ChallengeStatus.active.name)
        .snapshots()
        .map((snapshot) {
          final challenges = snapshot.docs
              .map((doc) => CompetitiveChallenge.fromJson(doc.data()))
              .toList();
          return challenges.where((c) => c.challengerId == userId || c.challengedPlayerId == userId).toList();
        });
  }

  @override
  Future<List<CompetitiveChallenge>> getChallengeHistory(String userId) async {
    final challengerQuery = await _challenges
        .where('challengerId', isEqualTo: userId)
        .where('status', whereIn: [
          ChallengeStatus.completed.name,
          ChallengeStatus.expired.name,
          ChallengeStatus.declined.name,
        ])
        .get();

    final opponentQuery = await _challenges
        .where('challengedPlayerId', isEqualTo: userId)
        .where('status', whereIn: [
          ChallengeStatus.completed.name,
          ChallengeStatus.expired.name,
          ChallengeStatus.declined.name,
        ])
        .get();

    final allDocs = [...challengerQuery.docs, ...opponentQuery.docs];
    final challenges = allDocs.map((doc) => CompetitiveChallenge.fromJson(doc.data())).toList();
    challenges.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return challenges;
  }

  @override
  Future<CompetitiveChallenge?> getChallenge(String challengeId) async {
    final doc = await _challenges.doc(challengeId).get();
    if (!doc.exists) return null;
    return CompetitiveChallenge.fromJson(doc.data()!);
  }
}
