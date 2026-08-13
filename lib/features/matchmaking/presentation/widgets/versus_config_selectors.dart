import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import '../providers/matchmaking_providers.dart';

class VersusCategorySelector extends ConsumerWidget {
  const VersusCategorySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(versusLobbyProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT CATEGORY',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final category = state.categories[index];
              final isSelected = state.category?.id == category.id;

              return Padding(
                padding: EdgeInsets.only(right: SoteriaSpacing.md),
                child: GestureDetector(
                  onTap: () => ref
                      .read(versusLobbyProvider.notifier)
                      .updateCategory(category),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected
                            ? SoteriaColors.primary
                            : Colors.white.withValues(alpha: 0.1),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: GlassSurface(
                        opacity: isSelected ? 0.15 : 0.05,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getIcon(category.icon),
                              color: isSelected ? SoteriaColors.primary : Colors.white70,
                              size: 32,
                            ),
                            SizedBox(height: SoteriaSpacing.sm),
                            Text(
                              category.name,
                              style: context.bodyMedium.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'security': return Icons.security_rounded;
      case 'cloud': return Icons.cloud_rounded;
      case 'code': return Icons.code_rounded;
      case 'network': return Icons.router_rounded;
      default: return Icons.category_rounded;
    }
  }
}

class VersusDifficultySelector extends ConsumerWidget {
  const VersusDifficultySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(versusLobbyProvider).difficulty;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: Difficulty.values.map((diff) {
            final isSelected = selected == diff;
            return ChoiceChip(
              label: Text(diff.name.toUpperCase()),
              selected: isSelected,
              onSelected: (_) => ref
                  .read(versusLobbyProvider.notifier)
                  .updateDifficulty(diff),
              selectedColor: SoteriaColors.primary.withValues(alpha: 0.2),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              labelStyle: TextStyle(
                color: isSelected ? SoteriaColors.primary : Colors.white60,
                fontSize: 10,
              ),
              showCheckmark: false,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class VersusQuestionCountSelector extends ConsumerWidget {
  const VersusQuestionCountSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(versusLobbyProvider).questionCount;
    final counts = [10, 20, 30];

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
              onTap: () => ref
                  .read(versusLobbyProvider.notifier)
                  .updateQuestionCount(count),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
