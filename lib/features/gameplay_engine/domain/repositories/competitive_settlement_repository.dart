import '../../models/competitive_settlement.dart';

abstract interface class CompetitiveSettlementRepository {
  /// Commits a settlement to the database using an atomic transaction.
  Future<void> finalizeSettlement(CompetitiveSettlement settlement);

  /// Generates a unique settlement receipt ID.
  String generateSettlementId();

  /// Retrieves a settlement by session ID.
  Future<CompetitiveSettlement?> getSettlementBySession(String sessionId);

  /// Retries a failed or offline settlement.
  Future<void> syncOfflineSettlement(CompetitiveSettlement settlement);
}
