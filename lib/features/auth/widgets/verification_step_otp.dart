import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import '../models/verification_type.dart';
import '../providers/verification_notifier.dart';
import 'soteria_otp_widget.dart';
import 'verification_countdown.dart';

class VerificationStepOtp extends ConsumerWidget {
  const VerificationStepOtp({super.key, required this.type});
  final VerificationType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationProvider(type));
    final notifier = ref.read(verificationProvider(type).notifier);
    final repository = ref.read(verificationRepositoryProvider);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('Enter Code', style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.sm),
        Text('Verification code for ${state.target}', style: context.bodyMedium),
        SizedBox(height: SoteriaSpacing.xl),
        SoteriaOtpWidget(
          onChanged: notifier.updateOtp,
          enabled: !state.isLoading,
        ),
        SizedBox(height: SoteriaSpacing.xxl),
        VerificationCountdown(
          seconds: state.countdown,
          onResend: () => notifier.resendCode(repository),
          isLoading: state.isLoading,
        ),
      ],
    );
  }
}
