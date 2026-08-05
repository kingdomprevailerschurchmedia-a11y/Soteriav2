import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';

class SoteriaErrorWidget extends StatelessWidget {
  const SoteriaErrorWidget({
    super.key,
    this.message = 'Something went wrong. Please try again.',
    this.onRetry,
    this.isFullPage = false,
  });

  final String message;
  final VoidCallback? onRetry;
  final bool isFullPage;

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: SoteriaColors.error,
              size: 48,
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              message,
              style: context.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: SoteriaSpacing.lg),
              SoteriaButton.ghost(
                label: 'Retry',
                onPressed: onRetry!,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );

    if (isFullPage) {
      return Scaffold(body: content);
    }

    return content;
  }
}
