import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_avatar.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import 'package:soteria/core/identity/models/user_profile.dart';
import 'package:soteria/features/auth/presentation/widgets/logout_confirmation_dialog.dart';

import '../../../../core/utils/soteria_responsive.dart';

class PlayerProfileScreen extends ConsumerWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: SoteriaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'PROFILE',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
            onPressed: () => context.push('/app/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.containerPadding(context),
        ),
        child: Column(
          children: [
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
            ),
            _buildHeader(context, profile),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.xlStatic),
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
                _ProfileTile(
                  icon: Icons.emoji_events_outlined,
                  title: 'Achievements',
                  onTap: () {},
                ),
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
            _buildLogoutButton(context),
            SizedBox(
              height:
                  SoteriaSpacing.adaptive(context, SoteriaSpacing.xxlStatic) +
                  MediaQuery.paddingOf(context).bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserProfile? profile) {
    final isShort = SoteriaResponsive.isShortScreen(context);
    final avatarSize = isShort ? 80.w : 100.w;

    return Column(
      children: [
        SoteriaAvatar(
          url: profile?.avatarUrl,
          size: avatarSize,
          isOnline: true,
        ),
        SizedBox(height: SoteriaSpacing.smallGap(context)),
        Text(
          profile?.displayName ?? 'Anonymous User',
          style: (isShort ? context.headlineSmall : context.headlineMedium)
              .copyWith(fontWeight: FontWeight.w900),
        ),
        Text(
          '@${profile?.username ?? 'guest'}',
          style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
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
          padding: EdgeInsets.only(
            left: SoteriaSpacing.sm,
            bottom: SoteriaSpacing.sm,
          ),
          child: Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SoteriaCard(
          padding: EdgeInsets.zero,
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ListTile(
      onTap: () => _showLogoutDialog(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      leading: const Icon(Icons.logout_rounded, color: SoteriaColors.error),
      title: Text(
        'LOG OUT',
        style: context.bodyLarge.copyWith(
          color: SoteriaColors.error,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: SoteriaColors.error,
      ),
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
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: context.bodyMedium),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: SoteriaColors.muted,
      ),
    );
  }
}
