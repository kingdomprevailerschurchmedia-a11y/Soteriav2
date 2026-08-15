import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/widgets/feedback/soteria_loader.dart';
import 'package:soteria/core/widgets/feedback/soteria_error_widget.dart';
import 'competitive_review_screen.dart';
import '../providers/pro_mode_review_provider.dart';

class ProModeQuestionReviewScreen extends ConsumerWidget {
  final String sessionId;

  const ProModeQuestionReviewScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewItemsAsync = ref.watch(proModeReviewProvider(sessionId));

    return reviewItemsAsync.when(
      loading: () => const SafeGradientScaffold(
        body: Center(child: SoteriaLoader()),
      ),
      error: (err, st) => SafeGradientScaffold(
        body: Center(
          child: SoteriaErrorWidget(
            message: 'FAILED TO LOAD REVIEW',
            onRetry: () => ref.refresh(proModeReviewProvider(sessionId)),
          ),
        ),
      ),
      data: (items) => CompetitiveReviewScreen(
        items: items,
        title: 'PRO MODE REVIEW',
      ),
    );
  }
}
