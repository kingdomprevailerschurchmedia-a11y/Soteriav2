import '../models/player_profile.dart';
import '../repositories/player_repository.dart';

class UpdatePlayerProfileUseCase {
  final PlayerRepository _repository;
  UpdatePlayerProfileUseCase(this._repository);

  Future<void> execute(PlayerProfile profile) =>
      _repository.updatePlayerProfile(profile);
}
