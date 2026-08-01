import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/navigation/soteria_chip.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';

class StepInterests extends ConsumerWidget {
  const StepInterests({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    final interests = [
      'Science', 'Technology', 'Business', 'Medicine', 'Arts', 'History',
      'Sports', 'Current Affairs', 'Programming', 'Mathematics', 'Engineering',
      'Languages', 'Law', 'Finance', 'Psychology', 'Design'
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select your interests',
            style: context.headlineMedium,
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            'Choose at least one to personalize your feed.',
            style: context.bodySmall.copyWith(color: Colors.grey),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: interests.map((interest) => SoteriaChip(
              label: interest,
              isSelected: state.interests.contains(interest),
              onTap: () => notifier.toggleInterest(interest),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
