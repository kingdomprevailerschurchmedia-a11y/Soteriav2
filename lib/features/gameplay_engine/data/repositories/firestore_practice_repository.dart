import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/practice_repository.dart';
import '../../models/practice_session.dart';
import '../../models/practice_session_config.dart';
import '../../../question_content/domain/entities/difficulty.dart';

class FirestorePracticeRepository implements PracticeRepository {
  final IDatabaseService _database;

  FirestorePracticeRepository(this._database);

  @override
  Future<void> createSession(PracticeSession session) async {
    await _database
        .collection('practice_sessions')
        .doc(session.sessionId)
        .set(session.toJson());
  }

  @override
  Future<PracticeSession?> getSession(String sessionId) async {
    final doc = await _database
        .collection('practice_sessions')
        .doc(sessionId)
        .get();
    if (!doc.exists) return null;

    final data = doc.data() as Map<String, dynamic>;
    return _fromJson(data);
  }

  @override
  Future<List<PracticeSession>> getRecentSessions(String uid, {int limit = 10}) async {
    final snapshot = await _database
        .collection('practice_sessions')
        .where('uid', isEqualTo: uid)
        .orderBy('startTime', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => _fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  PracticeSession _fromJson(Map<String, dynamic> json) {
    return PracticeSession(
      sessionId: json['sessionId'],
      uid: json['uid'],
      config: PracticeSessionConfig(
        category:
            null, // Category needs to be loaded separately or stored fully
        difficulty: Difficulty.values.firstWhere(
          (e) => e.name == json['config']['difficulty'],
        ),
        questionCount: json['config']['questionCount'],
        timerEnabled: json['config']['timerEnabled'],
        practiceType: json['config']['type'],
      ),
      startTime: DateTime.parse(json['startTime']),
      status: json['status'],
    );
  }
}
