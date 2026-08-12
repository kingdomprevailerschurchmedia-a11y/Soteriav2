import '../models/milestone.dart';

abstract interface class MilestoneRepository {
  /// Fetches all milestone definitions.
  Future<List<MilestoneDefinition>> getMilestoneDefinitions();

  /// Watches a player's milestone states.
  Stream<List<PlayerMilestone>> watchPlayerMilestones(String userId);

  /// Records milestone progress or completion.
  Future<void> updateMilestoneState(PlayerMilestone milestone);

  /// Fetches a specific player milestone.
  Future<PlayerMilestone?> getPlayerMilestone(
    String userId,
    String milestoneId,
  );
}
