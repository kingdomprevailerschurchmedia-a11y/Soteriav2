import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';
import 'package:soteria/features/personalization/widgets/selection_card.dart';

class StepGoals extends ConsumerWidget {
  const StepGoals({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    final goals = [
      {
        'title': 'Practice Daily',
        'subtitle': 'Build a consistent learning habit',
        'icon': Icons.timer_rounded,
      },
      {
        'title': 'Improve GPA',
        'subtitle': 'Master academic subjects',
        'icon': Icons.trending_up_rounded,
      },
      {
        'title': 'Prepare for Exams',
        'subtitle': 'Targeted practice for success',
        'icon': Icons.assignment_rounded,
      },
      {
        'title': 'Compete Nationally',
        'subtitle': 'Rise through the ranks',
        'icon': Icons.public_rounded,
      },
      {
        'title': 'Earn Rewards',
        'subtitle': 'Get recognized for your skills',
        'icon': Icons.card_giftcard_rounded,
      },
      {
        'title': 'General Learning',
        'subtitle': 'Explore new knowledge areas',
        'icon': Icons.auto_stories_rounded,
      },
    ];

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('What are your goals?', style: context.headlineMedium),
        SizedBox(height: SoteriaSpacing.xl),
        ...goals.map(
          (goal) => Padding(
            padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
            child: SelectionCard(
              title: goal['title'] as String,
              subtitle: goal['subtitle'] as String,
              icon: goal['icon'] as IconData,
              isSelected: state.goals.contains(goal['title']),
              onTap: () => notifier.toggleGoal(goal['title'] as String),
            ),
          ),
        ),
      ],
    );
  }
}
