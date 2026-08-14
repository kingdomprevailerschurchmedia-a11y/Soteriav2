import '../../models/practice_session.dart';

abstract interface class PracticeRepository {
  Future<void> createSession(PracticeSession session);
  Future<PracticeSession?> getSession(String sessionId);
  Future<List<PracticeSession>> getRecentSessions(String uid, {int limit = 10});
}
