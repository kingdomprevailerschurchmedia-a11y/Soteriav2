import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/features/player/domain/models/competitive_title.dart';
import 'package:soteria/features/player/presentation/providers/identity_providers.dart';

class TitleSelectionSheet extends ConsumerWidget {
  final List<CompetitiveTitle> ownedTitles;
  final String? currentlyEquippedId;

  const TitleSelectionSheet({
    super.key,
    required this.ownedTitles,
    this.currentlyEquippedId,
  });

  static Future<void> show(
    BuildContext context, {
    required List<CompetitiveTitle> ownedTitles,
    String? currentlyEquippedId,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TitleSelectionSheet(
        ownedTitles: ownedTitles,
        currentlyEquippedId: currentlyEquippedId,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: const BoxDecoration(
        color: SoteriaColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Text(
            'SELECT TITLE',
            style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            'Choose a title to showcase your career.',
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          if (ownedTitles.isEmpty)
            _buildEmptyState(context)
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: ownedTitles.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: SoteriaSpacing.md),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _TitleOption(
                      title: const CompetitiveTitle(
                        id: 'none',
                        name: 'No Title',
                        description: 'Display only your name.',
                      ),
                      isSelected: currentlyEquippedId == null,
                      onTap: () => _equip(ref, context, null),
                    );
                  }
                  final title = ownedTitles[index - 1];
                  return _TitleOption(
                    title: title,
                    isSelected: title.id == currentlyEquippedId,
                    onTap: () => _equip(ref, context, title.id),
                  );
                },
              ),
            ),
          SizedBox(height: SoteriaSpacing.xxl),
          SoteriaButton.secondary(
            label: 'CLOSE',
            onPressed: () => Navigator.pop(context),
            isFullWidth: true,
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.xl),
      child: Column(
        children: [
          Icon(Icons.lock_outline_rounded, color: SoteriaColors.muted, size: 48.sp),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            'No Titles Earned',
            style: context.titleMedium,
          ),
          Text(
            'Keep playing competitive to unlock titles.',
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _equip(WidgetRef ref, BuildContext context, String? id) async {
    await ref.read(competitiveIdentityControllerProvider.notifier).equipTitle(id);
    if (context.mounted) Navigator.pop(context);
  }
}

class _TitleOption extends StatelessWidget {
  final CompetitiveTitle title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TitleOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? SoteriaColors.primary.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? SoteriaColors.primary
                : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.name.toUpperCase(),
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? SoteriaColors.secondary : Colors.white,
                    ),
                  ),
                  Text(
                    title.description,
                    style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: SoteriaColors.secondary, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
