import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/presentation/screens/avatar_selection_screen.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_profile.dart';
import 'package:soteria/features/auth/presentation/widgets/logout_confirmation_dialog.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
import '../providers/progression_providers.dart';
import '../widgets/player_progression_card.dart';
import '../widgets/rank_history_section.dart';
import '../providers/identity_providers.dart';
import '../widgets/identity/competitive_identity_header.dart';
import 'competitive_showcase_screen.dart';

import '../../../../core/utils/soteria_responsive.dart';

class PlayerProfileScreen extends ConsumerWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final progressionAsync = ref.watch(competitiveProgressionProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'PROFILE',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: IconButton(
                icon: const Icon(Icons.settings_rounded, color: Colors.white, size: 20),
                onPressed: () => context.push('/app/settings'),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.containerPadding(context),
        ),
        child: Column(
          children: [
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
            ),
            _buildHeader(context, profile),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
            ),
            progressionAsync.when(
              data: (progression) => PlayerProgressionCard(
                progression: progression,
                displayName: profile?.displayName ?? 'Anonymous',
                avatarUrl: profile?.avatarUrl,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error loading progression: $err'),
            ),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
            ),
            _buildCompetitiveIdentity(context, ref),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
            ),
            const RankHistorySection(),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
            ),
            _buildSection(
              context,
              title: 'ACCOUNT',
              items: [
                _ProfileTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Personal Information',
                  onTap: () {},
                ),
                const _Divider(),
                _ProfileTile(
                  icon: Icons.history_rounded,
                  title: 'Competitive History',
                  onTap: () => context.push(SoteriaRoutes.competitiveHistory),
                ),
                const _Divider(),
                _ProfileTile(
                  icon: Icons.emoji_events_outlined,
                  title: 'Personal Records',
                  onTap: () => context.push(SoteriaRoutes.personalRecords),
                ),
                const _Divider(),
                _ProfileTile(
                  icon: Icons.bar_chart_rounded,
                  title: 'Statistics',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
            ),
            _buildSection(
              context,
              title: 'PREFERENCES',
              items: [
                _ProfileTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  onTap: () {},
                ),
                const _Divider(),
                _ProfileTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy & Security',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
            ),
            _buildSection(
              context,
              title: 'SUPPORT',
              items: [
                _ProfileTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help Center',
                  onTap: () {},
                ),
                const _Divider(),
                _ProfileTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About Soteria',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.xlStatic),
            ),
            _LogoutSection(onTap: () => _showLogoutDialog(context)),
            SizedBox(height: 20.h + MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildCompetitiveIdentity(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink(); // Hidden as per request to only redesign the top section
  }

  Widget _buildHeader(BuildContext context, UserProfile? profile) {
    return Row(
      children: [
        SoteriaAvatar(
          size: 100.w,
          isOnline: true,
          showGlow: true,
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile?.displayName ?? 'Anonymous User',
                style: context.headlineSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 24.sp,
                ),
              ),
              Text(
                '@${profile?.username ?? 'guest'}',
                style: context.bodyMedium.copyWith(
                  color: SoteriaColors.muted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _LevelBadge(level: 1),
                  SizedBox(width: 12.w),
                  _RankBadge(rank: 'UNRANKED'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 12),
          child: Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: SoteriaGradients.settingsCardBorder,
          ),
          padding: const EdgeInsets.all(1.5),
          child: GlassSurface(
            borderRadius: BorderRadius.circular(27),
            opacity: 0.1,
            child: Column(children: items),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const LogoutConfirmationDialog(),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;
  const _LevelBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF7C4DFF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFF7C4DFF),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$level',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
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

class _RankBadge extends StatelessWidget {
  final String rank;
  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
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
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: SoteriaColors.secondary, size: 22),
      ),
      title: Text(
        title,
        style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: SoteriaColors.secondary,
        size: 28,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.white.withValues(alpha: 0.05),
      indent: 70,
    );
  }
}

class _LogoutSection extends StatelessWidget {
  const _LogoutSection({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: SoteriaGradients.logoutBorder,
        ),
        padding: const EdgeInsets.all(1.5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            gradient: SoteriaGradients.logoutCard,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              const Icon(
                Icons.logout_rounded,
                color: SoteriaColors.error,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                'LOG OUT',
                style: context.titleSmall.copyWith(
                  color: SoteriaColors.error,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right_rounded,
                color: SoteriaColors.error,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
