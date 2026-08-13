import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';
import 'package:soteria/features/auth/presentation/widgets/logout_confirmation_dialog.dart';
import '../../../core/design_system/colors/soteria_colors.dart';
import '../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../core/design_system/typography/soteria_typography.dart';
import '../../../core/widgets/glass_surface.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'SETTINGS',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: IconButton(
                icon: const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 24),
                onPressed: () => context.pop(),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.containerPadding(context),
          vertical: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
        ),
        children: [
          _SettingsSection(
            title: 'ACCOUNT',
            items: [
              _SettingsItem(
                icon: Icons.person_outline_rounded,
                title: 'Profile Information',
                subtitle: 'View and edit your profile details',
                onTap: () {},
              ),
              const _Divider(),
              _SettingsItem(
                icon: Icons.security_rounded,
                title: 'Security & Password',
                subtitle: 'Manage your password and security',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
          ),
          _SettingsSection(
            title: 'PREFERENCES',
            items: [
              _SettingsItem(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                subtitle: 'Manage your notification preferences',
                onTap: () {},
              ),
              const _Divider(),
              _SettingsItem(
                icon: Icons.palette_outlined,
                title: 'Theme & Appearance',
                subtitle: 'Dark Mode',
                isThemeItem: true,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
          ),
          _SettingsSection(
            title: 'SUPPORT',
            items: [
              _SettingsItem(
                icon: Icons.help_outline_rounded,
                title: 'Help Center',
                subtitle: 'Get help and support',
                onTap: () {},
              ),
              const _Divider(),
              _SettingsItem(
                icon: Icons.info_outline_rounded,
                title: 'About Soteria',
                subtitle: 'App info, terms and more',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: SoteriaSpacing.adaptive(context, SoteriaSpacing.xlStatic),
          ),
          _LogoutSection(onTap: () => _showLogoutDialog(context)),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'You will be logged out of your account.',
              style: context.bodySmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom + 20),
        ],
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

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.items});
  final String title;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 12),
          child: Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
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
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.isThemeItem = false,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isThemeItem;
  final VoidCallback onTap;

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
      subtitle: subtitle != null
          ? Row(
              children: [
                if (isThemeItem) ...[
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF7C4DFF),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  subtitle!,
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          : null,
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
