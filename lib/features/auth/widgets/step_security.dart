import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/inputs/soteria_text_field.dart';
import '../providers/registration_notifier.dart';
import 'password_strength_indicator.dart';

class StepSecurity extends ConsumerStatefulWidget {
  const StepSecurity({super.key});

  @override
  ConsumerState<StepSecurity> createState() => _StepSecurityState();
}

class _StepSecurityState extends ConsumerState<StepSecurity> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registrationProvider);
    final notifier = ref.read(registrationProvider.notifier);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('Security', style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.sm),
        Text(
          'Protect your account with a strong password.',
          style: context.bodyMedium,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        SoteriaTextField(
          controller: _passwordController,
          label: 'Password',
          hintText: 'Enter secure password',
          obscureText: true,
          onChanged: (val) => notifier.updateSecurity(password: val),
          autofillHints: const [AutofillHints.newPassword],
        ),
        SizedBox(height: SoteriaSpacing.md),
        PasswordStrengthIndicator(password: state.password),
        SizedBox(height: SoteriaSpacing.lg),
        SoteriaTextField(
          controller: _confirmController,
          label: 'Confirm Password',
          hintText: 'Repeat password',
          obscureText: true,
          onChanged: (val) => notifier.updateSecurity(confirm: val),
          autofillHints: const [AutofillHints.newPassword],
        ),
      ],
    );
  }
}
