import '../models/player_presence.dart';

abstract class PresenceRepository {
  Stream<PlayerPresence?> watchPresence(String userId);
  
  Stream<Map<String, PlayerPresence>> watchPresenceMultiple(List<String> userIds);
  
  Future<void> updateStatus(String userId, PresenceStatus status, {String? matchId});
  
  Future<void> updatePrivacy(String userId, {bool? showOnlineStatus, bool? showActivity});
  
  Future<void> setOffline(String userId);
}
