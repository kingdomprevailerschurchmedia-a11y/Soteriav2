import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../question_content/domain/entities/difficulty.dart';
import '../../providers/practice_lobby_providers.dart';
import 'lobby_config_widgets.dart';

class DifficultySelector extends ConsumerWidget {
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(practiceLobbyProvider).config.difficulty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LobbySectionHeader(
          label: 'DIFFICULTY',
          icon: Icons.track_changes_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          childAspectRatio: 1.1,
          children: [
            LobbyDifficultyCard(
              isSelected: selected == Difficulty.easy,
              label: 'EASY',
              icon: Icons.eco_rounded,
              color: const Color(0xFF4CAF50),
              onTap: () => ref.read(practiceLobbyProvider.notifier).updateDifficulty(Difficulty.easy),
            ),
            LobbyDifficultyCard(
              isSelected: selected == Difficulty.medium,
              label: 'MEDIUM',
              icon: Icons.bar_chart_rounded,
              color: const Color(0xFF7C4DFF),
              onTap: () => ref.read(practiceLobbyProvider.notifier).updateDifficulty(Difficulty.medium),
            ),
            LobbyDifficultyCard(
              isSelected: selected == Difficulty.hard,
              label: 'HARD',
              icon: Icons.whatshot_rounded,
              color: const Color(0xFFFFAB40),
              onTap: () => ref.read(practiceLobbyProvider.notifier).updateDifficulty(Difficulty.hard),
            ),
            LobbyDifficultyCard(
              isSelected: selected == Difficulty.expert,
              label: 'EXPERT',
              icon: Icons.workspace_premium_rounded,
              color: const Color(0xFFFF5252),
              onTap: () => ref.read(practiceLobbyProvider.notifier).updateDifficulty(Difficulty.expert),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        LobbyAdaptiveToggle(
          isSelected: selected == Difficulty.adaptive,
          onTap: () => ref.read(practiceLobbyProvider.notifier).updateDifficulty(
            selected == Difficulty.adaptive ? Difficulty.medium : Difficulty.adaptive,
          ),
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
    final counts = [10, 20, 30, 50];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LobbySectionHeader(
          label: 'QUESTION COUNT',
          icon: Icons.list_alt_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: counts.map((count) {
            final isSelected = selected == count;
            return LobbyCountCircle(
              count: count,
              isSelected: isSelected,
              onTap: () => ref.read(practiceLobbyProvider.notifier).updateQuestionCount(count),
            );
          }).toList(),
        ),
      ],
    );
  }
}
