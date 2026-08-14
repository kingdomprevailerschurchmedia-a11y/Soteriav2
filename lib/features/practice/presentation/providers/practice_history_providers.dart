import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../gameplay_engine/providers/gameplay_providers.dart';
import '../../../gameplay_engine/models/game_result.dart';
import '../../../gameplay_engine/models/game_mode.dart';
import '../../../auth/providers/auth_providers.dart';

final practiceHistoryProvider = FutureProvider<List<GameResult>>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return [];
  
  final repository = ref.watch(gameplayRepositoryProvider);
  return repository.getRecentResults(userId, mode: GameMode.practice);
});
