import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import '../providers/matchmaking_providers.dart';
import '../../../dashboard/presentation/widgets/lobby/lobby_config_widgets.dart';

class VersusCategorySelector extends ConsumerWidget {
  const VersusCategorySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(versusLobbyProvider);

    if (state.isLoading && state.categories.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: SoteriaSpacing.md),
          SizedBox(
            height: 80.h,
            child: const Center(
              child: CircularProgressIndicator(
                color: SoteriaColors.gold,
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      );
    }

    if (state.categories.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: SoteriaSpacing.md),
          Container(
            height: 80.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.category_outlined, color: Colors.white24, size: 24.sp),
                SizedBox(height: 8.h),
                Text(
                  'No categories available',
                  style: context.bodySmall.copyWith(color: Colors.white24, fontSize: 9.sp),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        SizedBox(height: SoteriaSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 8.w,
            childAspectRatio: 1.1,
          ),
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];
            final isSelected = state.categoryIds.contains(category.id);

            return LobbyCategoryCard(
              label: category.name,
              icon: _getIcon(category.icon),
              isSelected: isSelected,
              onTap: () => ref
                  .read(versusLobbyProvider.notifier)
                  .toggleCategory(category.id),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const LobbySectionHeader(
      label: 'CATEGORY',
      icon: Icons.grid_view_rounded,
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'security': return Icons.security_rounded;
      case 'cloud': return Icons.cloud_rounded;
      case 'code': return Icons.code_rounded;
      case 'network': return Icons.router_rounded;
      case 'science': return Icons.science_rounded;
      case 'business': return Icons.business_rounded;
      case 'history': return Icons.history_rounded;
      case 'calculate': return Icons.calculate_rounded;
      case 'palette': return Icons.palette_rounded;
      case 'sports_basketball': return Icons.sports_basketball_rounded;
      case 'gavel': return Icons.gavel_rounded;
      case 'brush': return Icons.brush_rounded;
      case 'payments': return Icons.payments_rounded;
      case 'medical_services': return Icons.medical_services_rounded;
      case 'public': return Icons.public_rounded;
      case 'language': return Icons.language_rounded;
      case 'menu_book': return Icons.menu_book_rounded;
      case 'psychology': return Icons.psychology_rounded;
      case 'engineering': return Icons.engineering_rounded;
      case 'newspaper': return Icons.newspaper_rounded;
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
