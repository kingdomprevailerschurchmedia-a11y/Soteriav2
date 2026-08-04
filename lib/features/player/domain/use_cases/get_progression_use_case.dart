import '../models/player_profile.dart';
import '../models/progression.dart';
import '../services/progression_service.dart';

class GetProgressionUseCase {
  final ProgressionService _progressionService;

  GetProgressionUseCase(this._progressionService);

  Progression execute(PlayerProfile? player) {
    return _progressionService.calculateProgression(player);
  }
}
