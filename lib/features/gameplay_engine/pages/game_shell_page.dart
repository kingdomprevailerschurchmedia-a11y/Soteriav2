import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/pages/game_loading_view.dart';
import 'package:soteria/features/gameplay_engine/pages/game_playing_view.dart';
import 'package:soteria/features/gameplay_engine/pages/game_paused_view.dart';
import 'package:soteria/features/gameplay_engine/pages/game_result_view.dart';
import 'package:soteria/features/gameplay_engine/pages/competitive_playing_view.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/widgets/competitive_overlays.dart';
import 'package:soteria/features/gameplay_engine/providers/competitive_gameplay_providers.dart';

class GameShellPage extends ConsumerWidget {
  final GameConfiguration config;

  const GameShellPage({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameEngineProvider(config));
    final lifecycle = gameState.lifecycle;
    final notifier = ref.read(gameEngineProvider(config).notifier);

    // Initialize Pro Mode logic if needed
    if (config.mode == GameMode.pro) {
      ref.watch(proGameplayProvider(config));
    }

    return SafeGradientScaffold(
      body: Stack(
        children: [
          _buildBody(lifecycle, config, notifier),
          if (lifecycle == GameLifecycle.paused)
            config.mode == GameMode.pro
                ? ProPausedView(
                    onResume: notifier.resumeSession,
                    onQuit: notifier.cancelSession,
                  )
                : GamePausedView(
                    onResume: notifier.resumeSession,
                    onQuit: notifier.cancelSession,
                  ),
          if (gameState.isOffline && config.mode == GameMode.pro)
            ConnectionLostOverlay(
              onRetry: () => ref
                  .read(proGameplayProvider(config).notifier)
                  .checkConnection(),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(
    GameLifecycle lifecycle,
    GameConfiguration config,
    GameEngine notifier,
  ) {
    switch (lifecycle) {
      case GameLifecycle.initializing:
      case GameLifecycle.loading:
      case GameLifecycle.waiting:
        return const GameLoadingView();
      case GameLifecycle.playing:
      case GameLifecycle.paused:
      case GameLifecycle.answered:
        return config.mode == GameMode.pro
            ? CompetitivePlayingView(config: config)
            : GamePlayingView(config: config);
      case GameLifecycle.completed:
      case GameLifecycle.failed:
      case GameLifecycle.timeout:
      case GameLifecycle.cancelled:
        return Consumer(
          builder: (context, ref, _) {
            final score = ref.watch(
              gameEngineProvider(config).select((s) => s.score),
            );
            final xp = ref.watch(
              gameEngineProvider(config).select((s) => s.xp),
            );
            final status = ref.watch(
              gameEngineProvider(config).select((s) => s.lifecycle.name),
            );

            return GameResultView(
              score: score,
              xp: xp,
              status: status,
              onDone: () => Navigator.of(context).pop(),
            );
          },
        );
    }
  }
}
