import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../gameplay_engine/models/practice_session_config.dart';
import '../../providers/practice_lobby_providers.dart';

class DifficultySelector extends ConsumerWidget {
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(practiceLobbyProvider).config.difficulty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DIFFICULTY',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Wrap(
          spacing: 8,
          children: PracticeDifficulty.values.map((diff) {
            final isSelected = selected == diff;
            return ChoiceChip(
              label: Text(diff.name.toUpperCase()),
              selected: isSelected,
              onSelected: (_) => ref.read(practiceLobbyProvider.notifier).updateDifficulty(diff),
              selectedColor: SoteriaColors.primary.withValues(alpha: 0.2),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              labelStyle: TextStyle(
                color: isSelected ? SoteriaColors.primary : Colors.white60,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? SoteriaColors.primary : Colors.transparent,
                ),
              ),
              showCheckmark: false,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class QuestionCountSelector extends ConsumerWidget {
  const QuestionCountSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(practiceLobbyProvider).config.questionCount;
    final counts = [10, 20, 30, 50, 100];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUESTION COUNT',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: counts.map((count) {
            final isSelected = selected == count;
            return GestureDetector(
              onTap: () => ref.read(practiceLobbyProvider.notifier).updateQuestionCount(count),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? SoteriaColors.primary : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
