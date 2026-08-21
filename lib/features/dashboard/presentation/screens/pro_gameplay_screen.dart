import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../../core/widgets/overlays/soteria_dialog.dart';
import '../../../../features/gameplay_engine/models/game_configuration.dart';
import '../../../../features/gameplay_engine/models/game_mode.dart';
import '../../../../features/gameplay_engine/models/game_lifecycle.dart';
import '../../../../features/gameplay_engine/models/competitive_session.dart';
import '../../../../features/gameplay_engine/providers/game_engine_provider.dart';
import '../../../../features/gameplay_engine/providers/competitive_gameplay_providers.dart';
import '../../../../features/question_presentation/widgets/question_presenter.dart';
import '../../../../features/gameplay_engine/timer/widgets/adaptive_timer_display.dart';
import '../../../../features/gameplay_engine/timer/providers/timer_engine_provider.dart';
import '../../../../core/navigation/soteria_routes.dart';

class ProGameplayScreen extends ConsumerStatefulWidget {
  final CompetitiveSession session;

  const ProGameplayScreen({super.key, required this.session});

  @override
  ConsumerState<ProGameplayScreen> createState() => _ProGameplayScreenState();
}

class _ProGameplayScreenState extends ConsumerState<ProGameplayScreen> {
  late final GameConfiguration _gameConfig;

  @override
  void initState() {
    super.initState();
    _gameConfig = GameConfiguration(
      mode: GameMode.pro,
      questionCount: widget.session.config.questionCount,
      questionTimer: widget.session.config.timerEnabled 
          ? const Duration(seconds: 15) 
          : const Duration(seconds: 20), // Default timer if not specified
      allowLifelines: true,
      autoAdvance: false, // Don't auto-advance so user can read explanation
      difficultyMultiplier: _getMultiplier(widget.session.config.difficulty.name),
      categoryId: widget.session.config.category?.id,
      metadata: {
        'reservedFee': widget.session.reservedFee,
        'difficulty': widget.session.config.difficulty.toBaseDifficulty().name,
      },
    );
  }

  double _getMultiplier(String difficulty) {
    switch (difficulty) {
      case 'intermediate': return 1.2;
      case 'advanced': return 1.5;
      case 'expert': return 2.0;
      case 'adaptive': return 1.8;
      default: return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final engineState = ref.watch(gameEngineProvider(_gameConfig));
    // Watch ProGameplayNotifier for heartbeats
    ref.watch(proGameplayProvider(_gameConfig));

    if (engineState.lifecycle == GameLifecycle.initializing) {
      // Adopt robust initialization pattern from Practice mode
      Future.microtask(() {
        ref.read(gameEngineProvider(_gameConfig).notifier).startSession(
          widget.session.questions,
          sessionId: widget.session.sessionId,
        );
      });
      return const SafeGradientScaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SoteriaLoader(),
              SizedBox(height: 24),
              Text('PREPARING PRO MATCH...', style: TextStyle(color: SoteriaColors.gold, letterSpacing: 2, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    if (engineState.lifecycle == GameLifecycle.loading) {
      return const SafeGradientScaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SoteriaLoader(),
              SizedBox(height: 24),
              Text('PREPARING PRO MATCH...', style: TextStyle(color: SoteriaColors.gold, letterSpacing: 2, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    if (engineState.lifecycle == GameLifecycle.completed) {
      Future.microtask(() => context.go(SoteriaRoutes.proResults, extra: engineState));
      return const SafeGradientScaffold(body: Center(child: SoteriaLoader()));
    }

    if (engineState.lifecycle == GameLifecycle.failed) {
      return SafeGradientScaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(SoteriaSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: SoteriaColors.error,
                  size: 64,
                ),
                SizedBox(height: SoteriaSpacing.xl),
                Text(
                  'MATCH INITIALIZATION FAILED',
                  style: context.titleLarge.copyWith(
                    color: SoteriaColors.error,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SoteriaSpacing.md),
                Text(
                  'We encountered a secure communication error while starting your Pro Mode session. Your entry fee has been automatically refunded to your wallet.',
                  style: context.bodyMedium.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SoteriaSpacing.xxl),
                SoteriaButton.primary(
                  label: 'RETURN TO LOBBY',
                  onPressed: () => context.go(SoteriaRoutes.proMode),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        _handleExit(context);
      },
      child: SafeGradientScaffold(
        body: QuestionPresenter(
          question: engineState.currentQuestion!,
          currentQuestionIndex: engineState.currentQuestionIndex,
          totalQuestions: engineState.questions.length,
          sessionId: engineState.sessionId,
          gameConfig: _gameConfig,
          onClose: () => _handleExit(context),
          timerChild: Consumer(
            builder: (context, ref, _) {
              final timerState = ref.watch(timerEngineProvider);
              return AdaptiveTimerDisplay(state: timerState);
            },
          ),
        ),
      ),
    );
  }

  void _handleExit(BuildContext context) async {
    final bool? shouldExit = await SoteriaDialog.show(
      context,
      title: 'ABANDON PRO MATCH?',
      message: 'If you leave now, your entry fee of ${widget.session.reservedFee} coins will be forfeited.',
      confirmLabel: 'ABANDON',
      cancelLabel: 'CONTINUE',
      isDestructive: true,
      icon: Icons.warning_amber_rounded,
      iconColor: SoteriaColors.error,
    );

    if (shouldExit == true && context.mounted) {
      ref.read(gameEngineProvider(_gameConfig).notifier).cancelSession();
      context.go(SoteriaRoutes.proMode);
    }
  }
}
