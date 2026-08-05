import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/components/soteria_page_wrapper.dart';
import '../models/answer_review.dart';
import '../widgets/answer_review_card.dart';

class AnswerReviewScreen extends StatelessWidget {
  final List<AnswerReview> reviews;

  const AnswerReviewScreen({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return SoteriaPageWrapper(
      title: 'Answer Review',
      body: Column(
        children: [
          SizedBox(height: SoteriaSpacing.lg),
          ...reviews.map(
            (review) => Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.lg),
              child: AnswerReviewCard(review: review),
            ),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
        ],
      ),
    );
  }
}
