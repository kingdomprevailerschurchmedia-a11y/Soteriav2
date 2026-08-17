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
import '../widgets/profile/rank_progress_section.dart';
import '../widgets/profile/achievement_summary_section.dart';
import '../widgets/profile/engagement_summary_section.dart';
import '../widgets/profile/career_statistics_section.dart';

class PlayerProfileScreen extends ConsumerWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(competitiveProfileProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: profileAsync.when(
        data: (profile) => _buildProfileContent(context, profile, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => _buildErrorState(context, err),
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
            RepaintBoundary(child: _buildAccountSection(context)),
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
                color: SoteriaColors.primary,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SoteriaSpacing.gapXS,
            Text(
              'Profile',
              style: context.headlineLarge.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 28.sp,
              ),
            ),
            SoteriaSpacing.gapXS,
            Text(
              'Learn. Compete. Become Legendary.',
              style: context.bodySmall.copyWith(
                color: SoteriaColors.muted,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        _SettingsButton(onTap: () => context.push('/app/settings')),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'ACCOUNT',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w800,
              fontSize: 13.sp,
            ),
          ),
        ),
        GlassSurface(
          borderRadius: BorderRadius.circular(24),
          opacity: 0.05,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _AccountTile(
                icon: Icons.person_rounded,
                iconColor: const Color(0xFF7C4DFF),
                title: 'Profile Information',
                subtitle: 'View and edit your personal details',
                onTap: () => context.push(SoteriaRoutes.profileInformation),
              ),
              _AccountDivider(),
              _AccountTile(
                icon: Icons.account_balance_wallet_rounded,
                iconColor: SoteriaColors.xpColor,
                title: 'Wallet & Billing',
                subtitle: 'Manage your coins and transactions',
                onTap: () => context.push(SoteriaRoutes.rewards),
              ),
              _AccountDivider(),
              _AccountTile(
                icon: Icons.history_rounded,
                iconColor: const Color(0xFF00E5FF),
                title: 'Competitive History',
                subtitle: 'Your past matches and performance',
                onTap: () => context.push(SoteriaRoutes.competitiveHistory),
              ),
              _AccountDivider(),
              _AccountTile(
                icon: Icons.emoji_events_rounded,
                iconColor: SoteriaColors.gold,
                title: 'Achievements',
                subtitle: 'Your badges and milestones',
                onTap: () => context.push(SoteriaRoutes.achievements),
              ),
              _AccountDivider(),
              _AccountTile(
                icon: Icons.people_rounded,
                iconColor: SoteriaColors.primary,
                title: 'Friends',
                subtitle: 'Manage your competitive connections',
                onTap: () => context.push(SoteriaRoutes.friends),
              ),
              _AccountDivider(),
              _AccountTile(
                icon: Icons.settings_rounded,
                iconColor: const Color(0xFFA1887F),
                title: 'Settings',
                subtitle: 'Preferences and app settings',
                onTap: () => context.push('/app/settings'),
              ),
            ],
          ),
        ),
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
        icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 16),
        onPressed: onTap,
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _AccountTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Colors.white24,
        size: 24,
      ),
    );
  }
}

class _AccountDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.white.withValues(alpha: 0.03),
      indent: 72,
    );
  }
}
