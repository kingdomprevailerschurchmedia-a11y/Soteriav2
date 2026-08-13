import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/player/presentation/providers/challenge_lobby_providers.dart';
import 'package:soteria/features/question_content/domain/entities/category.dart';

class ChallengeCategorySelector extends ConsumerWidget {
  final String userId;
  const ChallengeCategorySelector({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeLobbyProvider(userId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CATEGORY',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final category = state.categories[index];
              final isSelected = state.category?.id == category.id;

              return _CategoryCard(
                category: category,
                isSelected: isSelected,
                onTap: () => ref
                    .read(challengeLobbyProvider(userId).notifier)
                    .updateCategory(category),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 120,
        margin: EdgeInsets.only(right: SoteriaSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? SoteriaColors.primary
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: GlassSurface(
            opacity: isSelected ? 0.15 : 0.05,
            child: Padding(
              padding: EdgeInsets.all(SoteriaSpacing.sm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIcon(category.icon),
                    color: isSelected ? SoteriaColors.primary : Colors.white70,
                    size: 24,
                  ),
                  SizedBox(height: SoteriaSpacing.xs),
                  Text(
                    category.name,
                    style: context.bodySmall.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

class ChallengeDifficultySelector extends ConsumerWidget {
  final String userId;
  const ChallengeDifficultySelector({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(challengeLobbyProvider(userId)).difficulty;

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
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: diff == Difficulty.hard ? 0 : 8),
                child: ChoiceChip(
                  label: Center(child: Text(diff.name.toUpperCase())),
                  selected: isSelected,
                  onSelected: (_) => ref
                      .read(challengeLobbyProvider(userId).notifier)
                      .updateDifficulty(diff),
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
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
