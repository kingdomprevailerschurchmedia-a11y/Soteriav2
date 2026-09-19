import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../../core/avatar/presentation/widgets/avatar_selection_dialog.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../../../core/design_system/components/soteria_progress_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/network/providers/connectivity_providers.dart';
import '../../../domain/models/player_profile.dart';
import '../../../domain/models/player_progression.dart';
import '../../../domain/services/competitive_ranking_engine.dart';
import '../../providers/streak_providers.dart';
import '../streak/momentum_indicator.dart';

class CompetitiveProfileHeader extends ConsumerWidget {
  final PlayerProfile identity;
  final PlayerProgression progression;
  final int globalPosition;

  const CompetitiveProfileHeader({
    super.key,
    required this.identity,
    required this.progression,
    required this.globalPosition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);

    return SoteriaCard(
      padding: EdgeInsets.all(24.r),
      borderRadius: 32,
      blur: 15.0,
      opacity: 0.05,
      borderColor: Colors.white.withValues(alpha: 0.1),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with circular glow
              GestureDetector(
                onTap: () => AvatarSelectionDialog.show(context),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            SoteriaColors.secondary,
                            SoteriaColors.primary,
                            Colors.transparent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: SoteriaColors.secondary.withValues(alpha: 0.3),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: SoteriaAvatar(
                        size: 96.w,
                        hasBorder: false,
                        isOnline: isOnline,
                        showStatus: false,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2E1A8A),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 16.w,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      identity.displayName,
                      style: context.headlineSmall.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 26.sp,
                      ),
                    ),
                    Text(
                      '@${identity.username}',
                      style: context.bodyMedium.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        _SmallBadge(
                          label: 'Lvl ${progression.currentLevel}',
                          icon: Icons.bolt_rounded,
                        ),
                        SizedBox(width: 8.w),
                        _SmallBadge(
                          label: progression.currentRank.toUpperCase(),
                          icon: Icons.emoji_events_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Edit Icon
              Icon(Icons.edit_outlined, color: Colors.white60, size: 20.r),
            ],
          ),
          SoteriaSpacing.gapLG,
          // Secondary Cards Row
          Row(
            children: [
              Expanded(
                child: _IdentitySubCard(
                  label: 'Total Coins',
                  value: identity.coins.toString(),
                  icon: Image.asset('assets/icons/coin_icon.png', width: 44.r),
                  onTap: () {},
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _IdentitySubCard(
                  label: 'Current Rank',
                  value: progression.currentRank,
                  icon: Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        progression.currentLevel.toString(),
                        style: context.titleMedium.copyWith(
                          color: SoteriaColors.gold,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallBadge extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SmallBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF9155FD).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF9155FD).withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: const Color(0xFFB456FF)),
          SizedBox(width: 6.w),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: const Color(0xFFE0E0E0),
              fontWeight: FontWeight.w900,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _IdentitySubCard extends StatelessWidget {
  final String label;
  final String value;
  final Widget icon;
  final VoidCallback onTap;

  const _IdentitySubCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    value,
                    style: context.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 18.r),
          ],
        ),
      ),
    );
  }
}
