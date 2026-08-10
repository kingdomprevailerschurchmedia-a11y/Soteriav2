import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/quiz_enums.dart';
import 'quiz_providers.dart';
import '../../../../core/identity/providers/identity_providers.dart';

enum RecoveryStatus {
  idle,
  checking,
  available,
  recovering,
  success,
  failed,
  expired,
  corrupted,
}

class RecoveryState {
  final RecoveryStatus status;
  final QuizSession? session;
  final String? error;

  const RecoveryState({
    this.status = RecoveryStatus.idle,
    this.session,
    this.error,
  });

  RecoveryState copyWith({
    RecoveryStatus? status,
    QuizSession? session,
    String? error,
  }) {
    return RecoveryState(
      status: status ?? this.status,
      session: session ?? this.session,
      error: error ?? this.error,
    );
  }
}

class RecoveryNotifier extends Notifier<RecoveryState> {
  @override
  RecoveryState build() {
    return const RecoveryState();
  }

  Future<void> checkForRecoverableSession() async {
    final userSession = ref.read(sessionProvider);
    if (!userSession.isAuthenticated || userSession.uid == null) {
      state = state.copyWith(status: RecoveryStatus.idle);
      return;
    }

    state = state.copyWith(status: RecoveryStatus.checking);

    try {
      final session = await ref
          .read(loadActiveSessionUseCaseProvider)
          .execute(userSession.uid!);

      if (session != null && _isRecoverable(session)) {
        state = state.copyWith(
          status: RecoveryStatus.available,
          session: session,
        );
      } else {
        state = state.copyWith(status: RecoveryStatus.idle);
      }
    } catch (e) {
      state = state.copyWith(
        status: RecoveryStatus.corrupted,
        error: e.toString(),
      );
    }
  }

  bool _isRecoverable(QuizSession session) {
    if (session.sessionStatus == SessionStatus.completed ||
        session.sessionStatus == SessionStatus.cancelled) {
      return false;
    }

    // Check expiration (e.g., 2 hours)
    final now = DateTime.now();
    const maxAge = Duration(hours: 2);
    if (now.difference(session.lastUpdatedTime ?? session.startedTime).abs() >
        maxAge) {
      return false;
    }

    return true;
  }

  Future<void> resumeSession() async {
    if (state.session == null) return;

    state = state.copyWith(status: RecoveryStatus.recovering);

    try {
      await ref
          .read(quizControllerProvider.notifier)
          .restoreQuiz(state.session!.sessionId);
      state = state.copyWith(status: RecoveryStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: RecoveryStatus.failed,
        error: e.toString(),
      );
    }
  }

  Future<void> discardSession() async {
    if (state.session == null) return;

    try {
      await ref
          .read(deleteSessionUseCaseProvider)
          .execute(state.session!.sessionId);
      state = state.copyWith(status: RecoveryStatus.idle, session: null);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final recoveryProvider = NotifierProvider<RecoveryNotifier, RecoveryState>(
  RecoveryNotifier.new,
);
