import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/widgets/navigation/soteria_chip.dart';
import '../providers/registration_notifier.dart';
import '../models/registration_draft.dart';

class StepReview extends ConsumerWidget {
  const StepReview({super.key, required this.onEdit});
  final Function(RegistrationStep) onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationProvider);
    final notifier = ref.read(registrationProvider.notifier);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('Review Your Profile', style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.xl),

        _ReviewSection(
          title: 'Account Info',
          onEdit: () => onEdit(RegistrationStep.account),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow(label: 'Name', value: '${state.firstName} ${state.lastName}'),
              _InfoRow(label: 'Username', value: '@${state.username}'),
              _InfoRow(label: 'Email', value: state.email),
            ],
          ),
        ),

        SizedBox(height: SoteriaSpacing.xl),
        _ReviewSection(
          title: 'Personalization (Pre-filled)',
          onEdit: null, // Defer editing personalization to settings for now
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow(label: 'Level', value: state.academicLevel ?? 'General'),
              SizedBox(height: SoteriaSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.interests.map((i) => SoteriaChip(label: i, isSelected: true)).toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: SoteriaSpacing.xxl),
        Row(
          children: [
            Checkbox(
              value: state.acceptedTerms,
              onChanged: (val) => notifier.toggleTerms(val ?? false),
              activeColor: SoteriaColors.gold,
            ),
            Expanded(
              child: Text(
                'I agree to the Terms of Service, Privacy Policy, and Community Guidelines.',
                style: context.bodySmall.copyWith(fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({required this.title, required this.child, this.onEdit});
  final String title;
  final Widget child;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title.toUpperCase(), style: context.labelSmall.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold)),
            if (onEdit != null)
              TextButton(onPressed: onEdit, child: const Text('Edit', style: TextStyle(color: SoteriaColors.muted))),
          ],
        ),
        SizedBox(height: SoteriaSpacing.sm),
        GlassSurface(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.bodySmall.copyWith(color: SoteriaColors.muted)),
          Text(value, style: context.bodyMedium),
        ],
      ),
    );
  }
}
