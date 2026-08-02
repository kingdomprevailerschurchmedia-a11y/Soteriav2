import '../models/player_profile.dart';
import '../repositories/player_repository.dart';

class ObservePlayerProfileUseCase {
  final PlayerRepository _repository;
  ObservePlayerProfileUseCase(this._repository);

  Stream<PlayerProfile?> execute(String uid) =>
      _repository.observePlayerProfile(uid);
}
