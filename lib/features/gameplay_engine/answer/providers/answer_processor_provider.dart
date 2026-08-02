import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/features/gameplay_engine/answer/models/answer_result.dart';
import 'package:soteria/features/gameplay_engine/answer/services/answer_processor.dart';

class AnswerStateNotifier extends StateNotifier<AnswerResult?> {
  AnswerStateNotifier() : super(null);

  void setResult(AnswerResult result) => state = result;
  void reset() => state = null;
}

final answerResultProvider =
    StateNotifierProvider.autoDispose<AnswerStateNotifier, AnswerResult?>((
      ref,
    ) {
      return AnswerStateNotifier();
    });

final answerProcessorProvider = Provider.autoDispose<AnswerProcessor>((ref) {
  return AnswerProcessor(
    onEvent: (event) {
      // Future: Forward to Analytics, Score Engine, etc.
    },
  );
});
