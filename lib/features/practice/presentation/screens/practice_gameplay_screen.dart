import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../../core/widgets/feedback/soteria_error_widget.dart';
import '../../../gameplay_engine/providers/game_engine_provider.dart';
import '../../../gameplay_engine/models/game_configuration.dart';
import '../../../gameplay_engine/models/game_mode.dart';
import '../../../gameplay_engine/models/game_lifecycle.dart';
import '../../../question_presentation/widgets/question_presenter.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../providers/practice_providers.dart';
import '../../../dashboard/presentation/providers/practice_lobby_providers.dart';
import '../../../../core/navigation/soteria_routes.dart';

class PracticeGameplayScreen extends ConsumerStatefulWidget {
  const PracticeGameplayScreen({super.key});

  @override
  ConsumerState<PracticeGameplayScreen> createState() => _PracticeGameplayScreenState();
}

class _PracticeGameplayScreenState extends ConsumerState<PracticeGameplayScreen> {
  @override
  Widget build(BuildContext context) {
    final questionsAsync = ref.watch(practiceQuestionsProvider);
    final lobbyState = ref.watch(practiceLobbyProvider);
    final config = lobbyState.config;

    return questionsAsync.when(
      data: (selectionResult) {
        if (selectionResult.questions.isEmpty) {
          return SafeGradientScaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No questions found for this configuration.', style: TextStyle(color: Colors.white)),
                  SizedBox(height: SoteriaSpacing.md),
                  SoteriaButton.secondary(
                    label: 'GO BACK',
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),
          );
        }

        final gameConfig = GameConfiguration(
          mode: GameMode.practice,
          questionCount: selectionResult.questions.length,
          categoryId: config.categoryIds.isNotEmpty ? config.categoryIds.first : null,
          allowLifelines: true,
          initialLives: 999,
        );

        final engineState = ref.watch(gameEngineProvider(gameConfig));

        if (engineState.lifecycle == GameLifecycle.loading || engineState.lifecycle == GameLifecycle.initializing) {
          // Initialize engine if not already done
          Future.microtask(() => ref.read(gameEngineProvider(gameConfig).notifier).startSession(selectionResult.questions));
          return const SafeGradientScaffold(body: Center(child: SoteriaLoader()));
        }

        if (engineState.lifecycle == GameLifecycle.completed) {
          Future.microtask(() => context.go(SoteriaRoutes.practiceResults, extra: engineState));
          return const SafeGradientScaffold(body: Center(child: SoteriaLoader()));
        }

        return SafeGradientScaffold(
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              _confirmExit(context);
            },
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context, engineState),
                  Expanded(
                    child: QuestionPresenter(
                      question: engineState.currentQuestion!,
                      currentQuestionIndex: engineState.currentQuestionIndex,
                      totalQuestions: engineState.questions.length,
                      sessionId: engineState.sessionId,
                      gameConfig: gameConfig,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const SafeGradientScaffold(body: Center(child: SoteriaLoader())),
      error: (error, _) => SafeGradientScaffold(
        body: Center(
          child: SoteriaErrorWidget(
            message: 'Failed to load questions: $error',
            onRetry: () => ref.refresh(practiceQuestionsProvider),
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
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => _confirmExit(context),
          ),
          Text(
            'Practice Mode',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(width: 48), // Spacer for centering
        ],
      ),
    );
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SoteriaConfirmDialog(
        title: 'Exit Practice?',
        message: 'Your progress in this session will be lost.',
        confirmLabel: 'EXIT',
        onConfirm: () {
          Navigator.pop(context);
          context.go(SoteriaRoutes.practice);
        },
      ),
    );
  }
}

class SoteriaConfirmDialog extends StatelessWidget {
  const SoteriaConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onConfirm,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: SoteriaColors.elevatedSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      content: Text(message, style: const TextStyle(color: Colors.white70)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL', style: TextStyle(color: Colors.white38)),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmLabel, style: const TextStyle(color: SoteriaColors.error, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
