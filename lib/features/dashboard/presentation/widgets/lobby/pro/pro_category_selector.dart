import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../providers/pro_lobby_providers.dart';
import '../lobby_config_widgets.dart';

import 'package:soteria/features/question_content/utils/category_icons.dart';

class ProCategorySelector extends ConsumerWidget {
  const ProCategorySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(proLobbyProvider);

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
                  style: context.bodySmall.copyWith(color: Colors.white24, fontSize: 10.sp),
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
            final isSelected = state.config.categoryIds.contains(category.id);

            return LobbyCategoryCard(
              label: category.name,
              icon: CategoryIcons.getIcon(category.icon),
              isSelected: isSelected,
              onTap: () => ref
                  .read(proLobbyProvider.notifier)
                  .toggleCategory(category.id),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const LobbySectionHeader(
      label: 'SELECT CATEGORY',
      icon: Icons.grid_view_rounded,
    );
  }
}
