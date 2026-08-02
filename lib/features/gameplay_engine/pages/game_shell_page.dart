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

class GameShellPage extends ConsumerWidget {
  final GameConfiguration config;

  const GameShellPage({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameEngineProvider(config));
    final notifier = ref.read(gameEngineProvider(config).notifier);

    return SafeGradientScaffold(
      body: Stack(
        children: [
          _buildBody(state.lifecycle, config, notifier),
          if (state.lifecycle == GameLifecycle.paused)
            GamePausedView(
              onResume: notifier.resumeSession,
              onQuit: notifier.cancelSession,
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
        return GamePlayingView(config: config);
      case GameLifecycle.completed:
      case GameLifecycle.failed:
      case GameLifecycle.timeout:
      case GameLifecycle.cancelled:
        return Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(gameEngineProvider(config));
            return GameResultView(
              score: state.score,
              xp: state.xp,
              status: state.lifecycle.name,
              onDone: () => Navigator.of(context).pop(),
            );
          },
        );
    }
  }
}
