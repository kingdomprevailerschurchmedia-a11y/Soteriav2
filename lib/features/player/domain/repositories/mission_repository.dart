import 'package:soteria/features/player/domain/models/competitive_mission.dart';

abstract class MissionRepository {
  Stream<List<CompetitiveMission>> watchActiveMissions(String userId);
  
  Stream<List<CompetitiveMission>> watchMissionsByPeriod(
    String userId,
    MissionPeriod period,
  );
  
  Future<List<CompetitiveMission>> getMissionHistory(String userId);
  
  Future<CompetitiveMission?> getMission(String userId, String missionId);
  
  Future<void> claimReward(String userId, String missionId);
  
  Future<void> refreshMissions(String userId);
}
