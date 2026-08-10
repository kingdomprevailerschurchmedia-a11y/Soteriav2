import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/soteria_routes.dart';
import '../../../../core/widgets/overlays/soteria_dialog.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../providers/recovery_providers.dart';

class SessionRecoveryDialog extends ConsumerWidget {
  const SessionRecoveryDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recoveryState = ref.watch(recoveryProvider);
    final session = recoveryState.session;

    if (recoveryState.status != RecoveryStatus.available || session == null) {
      return const SizedBox.shrink();
    }

    return SoteriaDialog(
      title: 'RESUME QUIZ?',
      message: 'You have an unfinished quiz from ${session.category}.\n'
          'Question ${session.currentQuestionIndex + 1} of ${session.questionIds.length}\n'
          'Score: ${session.currentScore}',
      confirmLabel: 'RESUME QUIZ',
      cancelLabel: 'DISCARD',
      icon: Icons.history_rounded,
      iconColor: SoteriaColors.primary,
      onConfirm: () async {
        await ref.read(recoveryProvider.notifier).resumeSession();
        if (context.mounted) {
          context.push(SoteriaRoutes.quizGameplay);
        }
      },
      onCancel: () async {
        await ref.read(recoveryProvider.notifier).discardSession();
      },
    );
  }

  static Future<void> checkAndShow(BuildContext context, WidgetRef ref) async {
    await ref.read(recoveryProvider.notifier).checkForRecoverableSession();
    if (context.mounted) {
      final state = ref.read(recoveryProvider);
      if (state.status == RecoveryStatus.available) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const SessionRecoveryDialog(),
        );
      }
    }
  }
}
