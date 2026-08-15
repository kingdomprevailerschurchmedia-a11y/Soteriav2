import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../../core/widgets/feedback/soteria_error_widget.dart';
import '../../../../core/widgets/overlays/soteria_dialog.dart';
import '../../../../features/gameplay_engine/models/game_configuration.dart';
import '../../../../features/gameplay_engine/models/game_mode.dart';
import '../../../../features/gameplay_engine/models/game_lifecycle.dart';
import '../../../../features/gameplay_engine/models/competitive_session.dart';
import '../../../../features/gameplay_engine/providers/game_engine_provider.dart';
import '../../../../features/gameplay_engine/providers/competitive_gameplay_providers.dart';
import '../../../../features/question_presentation/widgets/question_presenter.dart';
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
      questionTimer: widget.session.config.timerEnabled ? const Duration(seconds: 15) : null,
      allowLifelines: true,
      difficultyMultiplier: _getMultiplier(widget.session.config.difficulty.name),
      categoryId: widget.session.config.category?.id,
      metadata: {'reservedFee': widget.session.reservedFee},
    );

    // Initialize the engine with the locked questions from the session
    Future.microtask(() {
      ref.read(gameEngineProvider(_gameConfig).notifier).startSession(widget.session.questions);
    });
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

    if (engineState.lifecycle == GameLifecycle.loading || engineState.lifecycle == GameLifecycle.initializing) {
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

    if (engineState.lifecycle == GameLifecycle.completed || engineState.lifecycle == GameLifecycle.failed) {
      Future.microtask(() => context.go(SoteriaRoutes.proResults, extra: engineState));
      return const SafeGradientScaffold(body: Center(child: SoteriaLoader()));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        _handleExit(context);
      },
      child: SafeGradientScaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, engineState),
              Expanded(
                child: QuestionPresenter(
                  question: engineState.currentQuestion!,
                  currentQuestionIndex: engineState.currentQuestionIndex,
                  totalQuestions: engineState.questions.length,
                  sessionId: engineState.sessionId,
                  gameConfig: _gameConfig,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic state) {
    return Padding(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70),
            onPressed: () => _handleExit(context),
          ),
          Column(
            children: [
              Text(
                'PRO CHALLENGE',
                style: context.labelSmall.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              if (widget.session.config.category != null)
                Text(
                  widget.session.config.category!.name.toUpperCase(),
                  style: context.bodySmall.copyWith(color: Colors.white38, fontSize: 10.sp),
                ),
            ],
          ),
          _buildLives(state.lives),
        ],
      ),
    );
  }

  Widget _buildLives(int lives) {
    return Row(
      children: List.generate(3, (index) {
        final bool isActive = index < lives;
        return Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Icon(
            isActive ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isActive ? SoteriaColors.error : Colors.white10,
            size: 18.sp,
          ),
        );
      }),
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
