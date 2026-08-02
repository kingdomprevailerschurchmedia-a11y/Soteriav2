import 'package:soteria/features/gameplay_engine/answer/models/answer_submission.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';

/// Ensures submissions are valid before processing.
class AnswerValidator {
  static String? validate({
    required AnswerSubmission submission,
    required GameLifecycle lifecycle,
    required TimerStatus timerStatus,
    required bool alreadySubmitted,
    required bool allowMultipleSubmissions,
  }) {
    if (lifecycle != GameLifecycle.playing) {
      return 'Submission rejected: Session is not in active playing state.';
    }

    if (timerStatus == TimerStatus.expired) {
      return 'Submission rejected: Timer has already expired.';
    }

    if (alreadySubmitted && !allowMultipleSubmissions) {
      return 'Submission rejected: Duplicate submission not allowed for this mode.';
    }

    if (submission.selectedOptionIds.isEmpty) {
      return 'Submission rejected: No options selected.';
    }

    return null; // Valid
  }
}
