import '../models/player_profile.dart';
import '../repositories/player_repository.dart';

class CreatePlayerProfileUseCase {
  final PlayerRepository _repository;
  CreatePlayerProfileUseCase(this._repository);

  Future<void> execute(PlayerProfile profile) =>
      _repository.createPlayerProfile(profile);
}
