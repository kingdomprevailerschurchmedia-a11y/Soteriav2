import '../models/player_profile.dart';
import '../repositories/player_repository.dart';

class LoadPlayerProfileUseCase {
  final PlayerRepository _repository;
  LoadPlayerProfileUseCase(this._repository);

  Future<PlayerProfile?> execute(String uid) =>
      _repository.getPlayerProfile(uid);
}
