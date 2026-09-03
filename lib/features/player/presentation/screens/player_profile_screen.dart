import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import '../providers/competitive_profile_provider.dart';
import '../../domain/models/competitive_profile.dart';
import '../widgets/profile/competitive_profile_header.dart';
import '../widgets/profile/achievement_summary_section.dart';
import '../widgets/profile/engagement_summary_section.dart';
import '../widgets/profile/career_statistics_section.dart';

import '../../../../shared/widgets/soteria_page.dart';

class PlayerProfileScreen extends ConsumerWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(competitiveProfileProvider);

    return SoteriaPage(
      useSafeArea: false,
      showBackground: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: profileAsync.when(
          data: (profile) => _buildProfileContent(context, profile, ref),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => _buildErrorState(context, err),
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    CompetitiveProfile profile,
    WidgetRef ref,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(competitiveProfileProvider);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.containerPadding(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.paddingOf(context).top + 8.h),
            RepaintBoundary(child: _buildTopHeader(context)),
            SoteriaSpacing.gapLG,
            RepaintBoundary(
              child: CompetitiveProfileHeader(
                identity: profile.identity,
                progression: profile.progression,
                globalPosition: profile.globalPosition,
              ),
            ),
            SoteriaSpacing.gapLG,
            RepaintBoundary(
              child: EngagementSummarySection(
                progression: profile.progression,
                winStreak: profile.streak,
              ),
            ),
            SoteriaSpacing.gapLG,
            RepaintBoundary(
              child: AchievementSummarySection(
                earned: profile.earnedAchievements,
                total: profile.totalAchievements,
              ),
            ),
            SoteriaSpacing.gapLG,
            if (profile.careerSummary != null)
              RepaintBoundary(
                child: CareerStatisticsSection(summary: profile.careerSummary!),
              ),
            SoteriaSpacing.gapLG,
            SizedBox(height: 40.h + MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, color: SoteriaColors.error, size: 48.sp),
          SoteriaSpacing.gapMD,
          Text(
            'Failed to load profile',
            style: context.headlineSmall,
          ),
          SoteriaSpacing.gapSM,
          Text(
            error.toString(),
            style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'COMPETITIVE IDENTITY',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.secondary,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w900,
                fontSize: 11.sp,
              ),
            ),
            SoteriaSpacing.gapXS,
            Text(
              'Profile',
              style: context.headlineLarge.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 32.sp,
              ),
            ),
            SoteriaSpacing.gapXS,
            Text(
              'Learn. Compete. Become Legendary.',
              style: context.bodySmall.copyWith(
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        _SettingsButton(onTap: () => context.push('/app/settings')),
      ],
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SettingsButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 20),
        onPressed: onTap,
      ),
    );
  }
}
