import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Represents the visual state of an individual answer.
enum AnswerVisualState { normal, selected, correct, wrong, disabled, locked }

/// Manages the current user selection for a question session.
class AnswerSelectionNotifier extends StateNotifier<String?> {
  AnswerSelectionNotifier() : super(null);

  void select(String answerId) {
    if (state == answerId) {
      state = null; // Toggle off if already selected
    } else {
      state = answerId;
    }
  }

  void reset() => state = null;
}

final answerSelectionProvider =
    StateNotifierProvider.autoDispose<AnswerSelectionNotifier, String?>((ref) {
      return AnswerSelectionNotifier();
    });

/// Tracks if the answer has been "submitted" and the result is being revealed.
final isResultRevealedProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);
