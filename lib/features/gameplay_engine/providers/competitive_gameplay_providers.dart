import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/firebase/providers/firebase_providers.dart';
import '../domain/repositories/competitive_repository.dart';
import '../data/repositories/firestore_competitive_repository.dart';
import 'game_engine_provider.dart';
import '../models/game_configuration.dart';
import '../models/game_mode.dart';

final competitiveRepositoryProvider = Provider<CompetitiveRepository>((ref) {
  return FirestoreCompetitiveRepository(
    ref.watch(firestoreDatabaseServiceProvider),
  );
});

class ProGameplayNotifier extends StateNotifier<void> {
  final GameConfiguration config;
  final Ref ref;
  Timer? _heartbeatTimer;

  ProGameplayNotifier({required this.config, required this.ref}) : super(null) {
    if (config.mode == GameMode.pro) {
      _startHeartbeat();
    }
  }

  void _startHeartbeat() {
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      final engine = ref.read(gameEngineProvider(config).notifier);
      final state = engine.debugState;

      if (state.questions.isNotEmpty) {
        ref
            .read(competitiveRepositoryProvider)
            .updateSessionCheckpoint(state.sessionId, state);
      }
    });
  }

  void reportConnectionLoss() {
    final engine = ref.read(gameEngineProvider(config).notifier);
    engine.pauseSession();
  }

  Future<void> checkConnection() async {
    final engine = ref.read(gameEngineProvider(config).notifier);
    engine.resumeSession();
  }

  @override
  void dispose() {
    _heartbeatTimer?.cancel();
    super.dispose();
  }
}

final proGameplayProvider =
    StateNotifierProvider.family<ProGameplayNotifier, void, GameConfiguration>((
      ref,
      config,
    ) {
      return ProGameplayNotifier(config: config, ref: ref);
    });

final competitiveRewardProvider =
    Provider.family<Map<String, dynamic>, GameConfiguration>((ref, config) {
      final gameState = ref.watch(gameEngineProvider(config));

      // Pro Mode Multipliers (would normally come from Remote Config via config)
      final multiplier = config.difficultyMultiplier;
      final baseEntryFee = (gameState.metadata['reservedFee'] as int?) ?? 100;

      final currentAccuracy = gameState.questions.isEmpty
          ? 0.0
          : (gameState.score / (gameState.questions.length * 100));

      final potentialCoins =
          (baseEntryFee * 2 * multiplier * (currentAccuracy > 0.8 ? 1.2 : 1.0))
              .toInt();

      return {
        'coinsAtRisk': baseEntryFee,
        'potentialReward': potentialCoins,
        'multiplier': multiplier,
        'isWinZone': currentAccuracy > 0.6,
      };
    });
