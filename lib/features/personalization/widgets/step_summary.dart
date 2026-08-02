import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/core/widgets/navigation/soteria_chip.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';

class StepSummary extends ConsumerWidget {
  const StepSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('Review your profile', style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.xl),

        _SummarySection(
          title: 'Academic Level',
          onEdit: () => ref.read(personalizationProvider.notifier).setStep(0),
          child: Text(
            state.academicLevel ?? 'Not selected',
            style: context.bodyLarge,
          ),
        ),

        SizedBox(height: SoteriaSpacing.xl),
        _SummarySection(
          title: 'Interests',
          onEdit: () => ref.read(personalizationProvider.notifier).setStep(1),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: state.interests
                .map((i) => SoteriaChip(label: i, isSelected: true))
                .toList(),
          ),
        ),

        SizedBox(height: SoteriaSpacing.xl),
        _SummarySection(
          title: 'Your Goals',
          onEdit: () => ref.read(personalizationProvider.notifier).setStep(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.goals
                .map(
                  (g) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_rounded,
                          color: SoteriaColors.gold,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(g, style: context.bodyMedium),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({
    required this.title,
    required this.child,
    required this.onEdit,
  });

  final String title;
  final Widget child;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: context.labelSmall.copyWith(
                color: SoteriaColors.gold,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: onEdit,
              child: const Text(
                'Edit',
                style: TextStyle(color: SoteriaColors.muted),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GlassSurface(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ],
    );
  }
}
