import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/inputs/soteria_text_field.dart';
import '../models/verification_type.dart';
import 'password_strength_indicator.dart';

class VerificationStepResetPassword extends ConsumerStatefulWidget {
  const VerificationStepResetPassword({super.key, required this.type});
  final VerificationType type;

  @override
  ConsumerState<VerificationStepResetPassword> createState() => _VerificationStepResetPasswordState();
}

class _VerificationStepResetPasswordState extends ConsumerState<VerificationStepResetPassword> {
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('Create New Password', style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.sm),
        Text('Please enter a strong new password.', style: context.bodyMedium),
        SizedBox(height: SoteriaSpacing.xl),
        SoteriaTextField(
          label: 'New Password',
          obscureText: true,
          onChanged: (val) => setState(() => _password = val),
          autofillHints: const [AutofillHints.newPassword],
        ),
        SizedBox(height: SoteriaSpacing.md),
        PasswordStrengthIndicator(password: _password),
        SizedBox(height: SoteriaSpacing.lg),
        SoteriaTextField(
          label: 'Confirm New Password',
          obscureText: true,
          autofillHints: const [AutofillHints.newPassword],
        ),
      ],
    );
  }
}
