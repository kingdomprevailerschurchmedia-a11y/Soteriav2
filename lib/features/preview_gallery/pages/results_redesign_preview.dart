import 'package:flutter/material.dart';
import 'package:soteria/features/preview_gallery/widgets/preview_wrapper.dart';
import 'package:soteria/features/preview_gallery/models/mock_data_factory.dart';
import 'package:soteria/features/gameplay_engine/pages/results_screen.dart';
import 'package:soteria/features/gameplay_engine/pages/answer_review_screen.dart';

class ResultsRedesignPreview extends StatelessWidget {
  const ResultsRedesignPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewWrapper(
      title: 'Session Results Redesign',
      builder: (context, state) {
        GameResult result;

        switch (state) {
          case PreviewState.empty:
            result = MockDataFactory.createMockResult(isPerfect: true);
            break;
          case PreviewState.error:
            result = MockDataFactory.createFailedResult();
            break;
          case PreviewState.offline:
            result = MockDataFactory.createOfflineResult();
            break;
          default:
            result = MockDataFactory.createMockResult();
        }

        return ResultsScreen(result: result, onPlayAgain: () {}, onHome: () {});
      },
    );
  }
}

class AnswerReviewPreview extends StatelessWidget {
  const AnswerReviewPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewWrapper(
      title: 'Answer Review Preview',
      builder: (context, state) {
        final reviews = MockDataFactory.createMockReviews();
        return AnswerReviewScreen(reviews: reviews);
      },
    );
  }
}
