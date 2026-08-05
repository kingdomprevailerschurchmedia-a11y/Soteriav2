import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/widgets/buttons/soteria_button.dart';
import 'package:soteria/core/widgets/cards/soteria_card.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/features/auth/widgets/soteria_otp_widget.dart';
import 'package:soteria/features/auth/widgets/verification_countdown.dart';

class VerificationPreviewPage extends StatelessWidget {
  const VerificationPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SoteriaButton.primary(
          label: 'Email Verification Flow',
<<<<<<< HEAD
          onPressed: () =>
              context.push('${SoteriaRoutes.auth}/verify/emailVerification'),
=======
          onPressed: () => context.push('${SoteriaRoutes.auth}/verify/emailVerification'),
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
        ),
        const SizedBox(height: 12),
        SoteriaButton.secondary(
          label: 'Password Recovery Flow',
<<<<<<< HEAD
          onPressed: () =>
              context.push('${SoteriaRoutes.auth}/verify/passwordRecovery'),
        ),
        SizedBox(height: SoteriaSpacing.xl),

        Text('OTP Widget', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(child: SoteriaOtpWidget(onChanged: (_) {})),

        SizedBox(height: SoteriaSpacing.xl),
        Text(
          'Countdown States',
          style: Theme.of(context).textTheme.titleMedium,
        ),
=======
          onPressed: () => context.push('${SoteriaRoutes.auth}/verify/passwordRecovery'),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        
        Text('OTP Widget', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
          child: SoteriaOtpWidget(onChanged: (_) {}),
        ),
        
        SizedBox(height: SoteriaSpacing.xl),
        Text('Countdown States', style: Theme.of(context).textTheme.titleMedium),
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
        SizedBox(height: SoteriaSpacing.md),
        SoteriaCard(
          child: Column(
            children: [
              const VerificationCountdown(seconds: 45, onResend: _dummy),
              const SizedBox(height: 16),
              VerificationCountdown(seconds: 0, onResend: () {}),
            ],
          ),
        ),
      ],
    );
  }

  static void _dummy() {}
}
