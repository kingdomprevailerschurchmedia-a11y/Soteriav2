import '../../models/competitive_session.dart';

abstract interface class ProModeRepository {
  Future<bool> validateEntry(String uid, int fee);
  Future<void> reserveEntryFee(String uid, String sessionId, int fee);
  Future<void> createCompetitiveSession(CompetitiveSession session);
}
