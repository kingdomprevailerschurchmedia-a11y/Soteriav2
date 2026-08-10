import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/quiz_session.dart';
import '../domain/models/quiz_enums.dart';
import '../presentation/providers/recovery_providers.dart';
import '../presentation/widgets/session_recovery_dialog.dart';

class RecoveryPreviewWrapper extends StatelessWidget {
  const RecoveryPreviewWrapper({super.key, required this.state});

  final RecoveryState state;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        recoveryProvider.overrideWith(() => _MockRecoveryNotifier(state)),
      ],
      child: const Scaffold(
        backgroundColor: Color(0xFF0D081E),
        body: Center(
          child: SessionRecoveryDialog(),
        ),
      ),
    );
  }
}

class _MockRecoveryNotifier extends RecoveryNotifier {
  _MockRecoveryNotifier(this.initialState);
  final RecoveryState initialState;

  @override
  RecoveryState build() => initialState;
}

class RecoveryPreviews {
  static final mockSession = QuizSession(
    sessionId: 'mock_s1',
    playerId: 'p1',
    gameMode: GameMode.practice,
    category: 'Cybersecurity',
    difficulty: Difficulty.hard,
    startedTime: DateTime.now().subtract(const Duration(minutes: 15)),
    lastUpdatedTime: DateTime.now().subtract(const Duration(minutes: 5)),
    currentQuestionIndex: 5,
    questionIds: List.generate(10, (i) => 'q$i'),
    currentScore: 1250,
  );

  static Widget available() => RecoveryPreviewWrapper(
        state: RecoveryState(
          status: RecoveryStatus.available,
          session: mockSession,
        ),
      );

  static Widget recovering() => RecoveryPreviewWrapper(
        state: RecoveryState(
          status: RecoveryStatus.recovering,
          session: mockSession,
        ),
      );

  static Widget success() => RecoveryPreviewWrapper(
        state: RecoveryState(
          status: RecoveryStatus.success,
          session: mockSession,
        ),
      );

  static Widget failed() => RecoveryPreviewWrapper(
        state: RecoveryState(
          status: RecoveryStatus.failed,
          session: mockSession,
          error: 'Connection timed out while restoring session.',
        ),
      );
}
