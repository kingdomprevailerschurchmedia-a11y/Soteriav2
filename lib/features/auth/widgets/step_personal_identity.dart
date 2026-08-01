import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/inputs/soteria_text_field.dart';
import '../providers/registration_notifier.dart';

class StepPersonalIdentity extends ConsumerWidget {
  const StepPersonalIdentity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(registrationProvider.notifier);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('Personal Identity', style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.sm),
        Text('Tell us a bit about yourself to get started.', style: context.bodyMedium),
        SizedBox(height: SoteriaSpacing.xl),
        SoteriaTextField(
          label: 'First Name',
          hintText: 'e.g. Koffi',
          onChanged: (val) => notifier.updatePersonal(first: val),
          autofillHints: const [AutofillHints.givenName],
        ),
        SizedBox(height: SoteriaSpacing.lg),
        SoteriaTextField(
          label: 'Last Name',
          hintText: 'e.g. Mensah',
          onChanged: (val) => notifier.updatePersonal(last: val),
          autofillHints: const [AutofillHints.familyName],
        ),
        SizedBox(height: SoteriaSpacing.lg),
        SoteriaTextField(
          label: 'Display Name (Optional)',
          hintText: 'How you appear in competitions',
          onChanged: (val) => notifier.updatePersonal(display: val),
        ),
      ],
    );
  }
}
