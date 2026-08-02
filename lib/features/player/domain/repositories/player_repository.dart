import '../models/player_profile.dart';

abstract interface class PlayerRepository {
  Future<PlayerProfile?> getPlayerProfile(String uid);
  Stream<PlayerProfile?> observePlayerProfile(String uid);
  Future<void> createPlayerProfile(PlayerProfile profile);
  Future<void> updatePlayerProfile(PlayerProfile profile);
}
