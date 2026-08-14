import '../models/player_presence.dart';

abstract class PresenceRepository {
  Stream<PlayerPresence?> watchPresence(String userId);
  
  Stream<Map<String, PlayerPresence>> watchPresenceMultiple(List<String> userIds);
  
  Future<void> updatePresence(String userId, {
    PresenceStatus? status,
    String? matchId,
    bool? showOnlineStatus,
    bool? showActivity,
    bool? showMatchStatus,
    bool heartbeatOnly = false,
  });
  
  Future<void> setOffline(String userId);
}
