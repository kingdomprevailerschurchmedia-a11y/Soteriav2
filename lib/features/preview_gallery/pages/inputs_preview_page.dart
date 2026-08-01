import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/inputs/soteria_text_field.dart';
import 'package:soteria/core/widgets/inputs/soteria_otp_field.dart';
import 'package:soteria/core/widgets/typography/soteria_text.dart';
import 'package:soteria/core/logging/logger_service.dart';

class InputsPreviewPage extends StatelessWidget {
  const InputsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        const SoteriaTextField(
          label: 'Email Address',
          hintText: 'Enter your email',
          prefixIcon: Icons.email_outlined,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaTextField(
          label: 'Password',
          hintText: 'Enter your password',
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: true,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaTextField(
          label: 'Referral Code (Optional)',
          hintText: 'SOTERIA-2026',
          enabled: false,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('OTP FIELD'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaOtpField(
          length: 4,
          onCompleted: (code) => LoggerService.i('OTP: $code'),
        ),
      ],
    );
  }
}
