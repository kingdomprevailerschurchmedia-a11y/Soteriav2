import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_profile.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import '../providers/progression_providers.dart';
import '../widgets/player_progression_card.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/soteria_responsive.dart';

class PlayerProfileScreen extends ConsumerWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final progressionAsync = ref.watch(competitiveProgressionProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.containerPadding(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.paddingOf(context).top + 20.h),
            _buildTopHeader(context),
            SizedBox(height: 16.h),
            _buildUserInfo(context, profile),
            SizedBox(height: 24.h),
            progressionAsync.when(
              data: (progression) => PlayerProgressionCard(
                progression: progression,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error loading progression: $err'),
            ),
            SizedBox(height: 24.h),
            _buildCompetitiveHistory(context),
            SizedBox(height: 24.h),
            _buildAccountSection(context),
            SizedBox(height: 32.h + MediaQuery.paddingOf(context).bottom),
          ],
        ),
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
              'Profile',
              style: context.headlineLarge.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 26.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Learn. Compete. Become Legendary.',
              style: context.bodyMedium.copyWith(
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

  Widget _buildUserInfo(BuildContext context, UserProfile? profile) {
    return Row(
      children: [
        const _AvatarWithRing(),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile?.displayName ?? 'Anonymous User',
                style: context.headlineSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                '@${profile?.username ?? 'guest'}',
                style: context.bodyLarge.copyWith(
                  color: SoteriaColors.muted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  const _LevelBadge(level: 1),
                  SizedBox(width: 10.w),
                  const _RankBadge(rank: 'UNRANKED'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompetitiveHistory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events_rounded, color: SoteriaColors.gold, size: 18.sp),
                SizedBox(width: 10.w),
                Text(
                  'COMPETITIVE HISTORY',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.gold,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w900,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => context.push(SoteriaRoutes.competitiveHistory),
              child: Row(
                children: [
                  Text(
                    'View All',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: SoteriaColors.muted, size: 16.sp),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        GlassSurface(
          borderRadius: BorderRadius.circular(24),
          opacity: 0.03,
          padding: EdgeInsets.all(24.w),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: SoteriaColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.calendar_today_rounded,
                    color: SoteriaColors.secondary.withValues(alpha: 0.6),
                    size: 24.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No competitive matches played yet.',
                  style: context.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Jump in and start your journey!',
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
              ],
            ),
          ),
        ),
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
              color: SoteriaColors.muted,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w900,
              fontSize: 11.sp,
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
                title: 'Personal Information',
                subtitle: 'View and update your details',
                onTap: () {},
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
                onTap: () => context.push(SoteriaRoutes.personalRecords),
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
    return GlassSurface(
      borderRadius: BorderRadius.circular(12),
      opacity: 0.08,
      padding: EdgeInsets.zero,
      child: IconButton(
        icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 22),
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      ),
    );
  }
}

class _AvatarWithRing extends StatelessWidget {
  const _AvatarWithRing();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SoteriaGradients.avatarRingGradient,
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: const BoxDecoration(
          color: SoteriaColors.background,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(2),
        child: const SoteriaAvatar(
          size: 74,
          isOnline: true,
          hasBorder: false,
        ),
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;
  const _LevelBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF7C4DFF).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _HexagonLevel(level: level),
          SizedBox(width: 8.w),
          Text(
            'Level $level',
            style: context.labelSmall.copyWith(
              color: const Color(0xFFE1BEE7),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _HexagonLevel extends StatelessWidget {
  final int level;
  const _HexagonLevel({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        color: const Color(0xFF7C4DFF),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          '$level',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  final String rank;
  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF2196F3).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_events_rounded, color: const Color(0xFF2196F3), size: 14.sp),
          SizedBox(width: 8.w),
          Text(
            rank,
            style: context.labelSmall.copyWith(
              color: const Color(0xFFBBDEFB),
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
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
