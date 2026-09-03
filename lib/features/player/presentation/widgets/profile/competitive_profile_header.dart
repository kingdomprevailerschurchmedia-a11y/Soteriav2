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
    final momentumAsync = ref.watch(currentMomentumProvider);
    final isOnline = ref.watch(isOnlineProvider);
    final engine = CompetitiveRankingEngine();
    final rankInfo = engine.calculateRankProgress(progression.rankPoints);

    return SoteriaCard(
      hasGlow: true,
      glowColor: SoteriaColors.primary.withValues(alpha: 0.1),
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => AvatarSelectionDialog.show(context),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: SoteriaColors.secondary.withValues(alpha: 0.4),
                          width: 2.w,
                        ),
                      ),
                      child: SoteriaAvatar(
                        imageUrl: identity.photoUrl,
                        size: 90.w,
                        hasBorder: false,
                        isOnline: isOnline,
                        showStatus: false,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1638),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: SoteriaColors.secondary.withValues(alpha: 0.5),
                          width: 1.5.w,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 16.w,
                        color: SoteriaColors.secondary,
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
                    AutoSizeText(
                      identity.displayName,
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 1,
                      minFontSize: 20,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AutoSizeText(
                      '@${identity.username}',
                      maxLines: 1,
                      minFontSize: 12,
                      style: context.bodyMedium.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        _IdentityBadge(
                          label: 'Lvl ${progression.currentLevel}',
                          color: const Color(0xFF7C4DFF),
                          icon: Icons.bolt_rounded,
                        ),
                        SizedBox(width: 8.w),
                        _IdentityBadge(
                          label: progression.currentRank.toUpperCase(),
                          color: const Color(0xFF7C4DFF),
                          icon: Icons.emoji_events_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SoteriaSpacing.gapLG,
          
          // XP Progress
          _buildProgressRow(
            context,
            label: 'CAREER XP',
            value: 'Lvl ${progression.currentLevel}',
            progress: progression.xpProgress,
            color: SoteriaColors.xpColor,
            fractionText: '${progression.currentXp} / ${progression.xpRequiredForNextLevel - progression.xpRequiredForCurrentLevel} XP',
          ),
          
          SoteriaSpacing.gapMD,
          
          // Rank Progress
          _buildProgressRow(
            context,
            label: 'RANK PROGRESS',
            value: rankInfo.isMaxRank ? 'ELITE' : '${(rankInfo.progressPercentage * 100).toInt()}%',
            progress: rankInfo.progressPercentage,
            color: const Color(0xFF322A4D), // Darker bar color for Rank Progress as in image
            isDarkBar: true,
          ),

          SoteriaSpacing.gapLG,
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COMPETITIVE STANDING (RP)',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      letterSpacing: 1.2,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${progression.rankPoints} RP',
                    style: context.headlineMedium.copyWith(
                      color: SoteriaColors.textPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: SoteriaColors.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.2)),
                ),
                child: Icon(
                  Icons.stars_rounded,
                  color: SoteriaColors.gold,
                  size: 28.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow(
    BuildContext context, {
    required String label,
    required String value,
    required double progress,
    required Color color,
    String? fractionText,
    bool isDarkBar = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 1.2,
                fontSize: 10.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              value,
              style: context.labelSmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            SoteriaProgressBar(
              progress: progress,
              color: isDarkBar ? Colors.white.withValues(alpha: 0.05) : color,
              height: 8,
              hasGlow: !isDarkBar,
            ),
            if (fractionText != null)
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: Text(
                  fractionText,
                  style: context.labelSmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _IdentityBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _IdentityBadge({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.w, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
