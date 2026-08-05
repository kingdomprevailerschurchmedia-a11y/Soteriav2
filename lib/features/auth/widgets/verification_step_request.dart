import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/inputs/soteria_text_field.dart';
import '../models/verification_type.dart';
import '../providers/verification_notifier.dart';

class VerificationStepRequest extends ConsumerWidget {
  const VerificationStepRequest({super.key, required this.type});
  final VerificationType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
<<<<<<< HEAD
    final state = ref.watch(verificationProvider);
    final notifier = ref.read(verificationProvider.notifier);
=======
    final state = ref.watch(verificationProvider(type));
    final notifier = ref.read(verificationProvider(type).notifier);
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text(type.title, style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.sm),
        Text(type.description, style: context.bodyMedium),
        SizedBox(height: SoteriaSpacing.xl),
        SoteriaTextField(
          label: 'Email Address',
          hintText: 'name@example.com',
          onChanged: notifier.updateTarget,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          enabled: !state.isLoading,
        ),
      ],
    );
  }
}
