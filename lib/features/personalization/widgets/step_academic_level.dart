import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';
import 'package:soteria/features/personalization/widgets/selection_card.dart';

class StepAcademicLevel extends ConsumerWidget {
  const StepAcademicLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    final options = [
      {'title': 'Secondary School', 'icon': Icons.school_rounded},
      {'title': 'University', 'icon': Icons.account_balance_rounded},
      {'title': 'Graduate', 'icon': Icons.workspace_premium_rounded},
      {'title': 'Professional', 'icon': Icons.business_center_rounded},
      {'title': 'General Knowledge', 'icon': Icons.menu_book_rounded},
    ];

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text(
          'What is your current academic level?',
          style: context.headlineMedium,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        ...options.map((opt) => Padding(
          padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
          child: SelectionCard(
            title: opt['title'] as String,
            icon: opt['icon'] as IconData,
            isSelected: state.academicLevel == opt['title'],
            onTap: () => notifier.setAcademicLevel(opt['title'] as String),
          ),
        )),
      ],
    );
  }
}
