import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import '../providers/matchmaking_providers.dart';
import '../../../dashboard/presentation/widgets/lobby/lobby_config_widgets.dart';

class VersusCategorySelector extends ConsumerWidget {
  const VersusCategorySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(versusLobbyProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LobbySectionHeader(
          label: 'CATEGORY',
          icon: Icons.grid_view_rounded,
        ),
        SizedBox(height: SoteriaSpacing.md),
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final category = state.categories[index];
              final isSelected = state.category?.id == category.id;

              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () => ref
                      .read(versusLobbyProvider.notifier)
                      .updateCategory(category),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? SoteriaColors.primary
                            : Colors.white.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: GlassSurface(
                        opacity: isSelected ? 0.15 : 0.05,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getIcon(category.icon),
                              color: isSelected ? SoteriaColors.primary : Colors.white70,
                              size: 24.sp,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              category.name,
                              style: context.bodySmall.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 9.sp,
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
              onTap: () => ref.read(versusLobbyProvider.notifier).updateDifficulty(Difficulty.easy),
            ),
            LobbyDifficultyCard(
              isSelected: selected == Difficulty.medium,
              label: 'MEDIUM',
              icon: Icons.bar_chart_rounded,
              color: const Color(0xFF7C4DFF),
              onTap: () => ref.read(versusLobbyProvider.notifier).updateDifficulty(Difficulty.medium),
            ),
            LobbyDifficultyCard(
              isSelected: selected == Difficulty.hard,
              label: 'HARD',
              icon: Icons.whatshot_rounded,
              color: const Color(0xFFFFAB40),
              onTap: () => ref.read(versusLobbyProvider.notifier).updateDifficulty(Difficulty.hard),
            ),
            LobbyDifficultyCard(
              isSelected: selected == Difficulty.expert,
              label: 'EXPERT',
              icon: Icons.workspace_premium_rounded,
              color: const Color(0xFFFF5252),
              onTap: () => ref.read(versusLobbyProvider.notifier).updateDifficulty(Difficulty.expert),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        LobbyAdaptiveToggle(
          isSelected: selected == Difficulty.adaptive,
          onTap: () => ref.read(versusLobbyProvider.notifier).updateDifficulty(
            selected == Difficulty.adaptive ? Difficulty.medium : Difficulty.adaptive,
          ),
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
              onTap: () => ref.read(versusLobbyProvider.notifier).updateQuestionCount(count),
            );
          }).toList(),
        ),
      ],
    );
  }
}
