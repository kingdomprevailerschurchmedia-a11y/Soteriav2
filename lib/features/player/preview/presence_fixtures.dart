import '../domain/models/player_presence.dart';

class PresenceFixtures {
  static PlayerPresence online(String userId) => PlayerPresence(
    userId: userId,
    status: PresenceStatus.online,
    lastSeenAt: DateTime.now(),
  );

  static PlayerPresence inMatch(String userId, String matchId) => PlayerPresence(
    userId: userId,
    status: PresenceStatus.inMatch,
    lastSeenAt: DateTime.now(),
    currentMatchId: matchId,
  );

  static PlayerPresence recentlyActive(String userId) => PlayerPresence(
    userId: userId,
    status: PresenceStatus.recentlyActive,
    lastSeenAt: DateTime.now().subtract(const Duration(minutes: 15)),
  );

  static PlayerPresence offline(String userId) => PlayerPresence(
    userId: userId,
    status: PresenceStatus.offline,
    lastSeenAt: DateTime.now().subtract(const Duration(hours: 4)),
  );
}
