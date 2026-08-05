import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';

class VerificationCountdown extends StatelessWidget {
  const VerificationCountdown({
    super.key,
    required this.seconds,
    required this.onResend,
    this.isLoading = false,
  });

  final int seconds;
  final VoidCallback onResend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (seconds > 0)
          Text(
            'Resend code in ${seconds}s',
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          )
        else
          SoteriaButton.text(
            label: 'Resend Verification Code',
            onPressed: isLoading ? null : onResend,
          ),
      ],
    );
  }
}
