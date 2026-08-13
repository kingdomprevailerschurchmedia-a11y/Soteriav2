import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/features/player/domain/models/competitive_badge.dart';
import 'package:soteria/features/player/presentation/providers/identity_providers.dart';

class BadgeCustomizationSheet extends ConsumerStatefulWidget {
  final List<CompetitiveBadge> ownedBadges;
  final List<String> initialFeaturedIds;

  const BadgeCustomizationSheet({
    super.key,
    required this.ownedBadges,
    required this.initialFeaturedIds,
  });

  static Future<void> show(
    BuildContext context, {
    required List<CompetitiveBadge> ownedBadges,
    required List<String> initialFeaturedIds,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BadgeCustomizationSheet(
        ownedBadges: ownedBadges,
        initialFeaturedIds: initialFeaturedIds,
      ),
    );
  }

  @override
  ConsumerState<BadgeCustomizationSheet> createState() =>
      _BadgeCustomizationSheetState();
}

class _BadgeCustomizationSheetState
    extends ConsumerState<BadgeCustomizationSheet> {
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.initialFeaturedIds);
  }

  void _toggleBadge(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        if (_selectedIds.length < 5) {
          _selectedIds.add(id);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            'FEATURED BADGES',
            style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            'Select up to 5 badges to showcase (${_selectedIds.length}/5)',
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          if (widget.ownedBadges.isEmpty)
            _buildEmptyState(context)
          else
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: widget.ownedBadges.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: SoteriaSpacing.md,
                  crossAxisSpacing: SoteriaSpacing.md,
                ),
                itemBuilder: (context, index) {
                  final badge = widget.ownedBadges[index];
                  final isSelected = _selectedIds.contains(badge.id);
                  return GestureDetector(
                    onTap: () => _toggleBadge(badge.id),
                    child: _BadgeIcon(badge: badge, isSelected: isSelected),
                  );
                },
              ),
            ),
          SizedBox(height: SoteriaSpacing.xxl),
          Row(
            children: [
              Expanded(
                child: SoteriaButton.secondary(
                  label: 'CANCEL',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: SoteriaButton.primary(
                  label: 'SAVE',
                  onPressed: _selectedIds.length <= 5 ? _save : null,
                  isLoading: ref.watch(competitiveIdentityControllerProvider).isLoading,
                ),
              ),
            ],
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
          Icon(Icons.emoji_events_outlined, color: SoteriaColors.muted, size: 48.sp),
          SizedBox(height: SoteriaSpacing.md),
          Text('No Badges Owned', style: context.titleMedium),
          Text(
            'Earn badges by reaching milestones and ranks.',
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    await ref.read(competitiveIdentityControllerProvider.notifier).updateFeaturedBadges(_selectedIds);
    if (mounted) Navigator.pop(context);
  }
}

class _BadgeIcon extends StatelessWidget {
  final CompetitiveBadge badge;
  final bool isSelected;

  const _BadgeIcon({required this.badge, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? SoteriaColors.gold.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.03),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(
          color: isSelected
              ? SoteriaColors.gold
              : Colors.white.withValues(alpha: 0.05),
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.emoji_events_rounded,
            color: isSelected ? SoteriaColors.gold : SoteriaColors.muted,
            size: 24.sp,
          ),
          if (isSelected)
            Positioned(
              top: 2,
              right: 2,
              child: Icon(Icons.check_circle, color: SoteriaColors.gold, size: 12.sp),
            ),
        ],
      ),
    );
  }
}
