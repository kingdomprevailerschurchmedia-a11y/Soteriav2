import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/inputs/soteria_text_field.dart';
import '../providers/registration_notifier.dart';

class StepAccountIdentity extends ConsumerWidget {
  const StepAccountIdentity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(registrationProvider.notifier);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('Account Identity', style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.sm),
        Text('Choose a unique username and valid email.', style: context.bodyMedium),
        SizedBox(height: SoteriaSpacing.xl),
        SoteriaTextField(
          label: 'Email Address',
          hintText: 'name@example.com',
          onChanged: (val) => notifier.updateAccount(email: val),
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
        ),
        SizedBox(height: SoteriaSpacing.lg),
        SoteriaTextField(
          label: 'Username',
          hintText: 'e.g. knowledge_king',
          onChanged: (val) => notifier.updateAccount(username: val),
          autofillHints: const [AutofillHints.username],
        ),
      ],
    );
  }
}
