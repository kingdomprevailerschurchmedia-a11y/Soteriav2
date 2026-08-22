import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/navigation/soteria_routes.dart';
import 'package:soteria/features/auth/presentation/widgets/logout_confirmation_dialog.dart';
import 'package:soteria/shared/widgets/soteria_page.dart';
import '../../../core/design_system/colors/soteria_colors.dart';
import '../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../core/design_system/typography/soteria_typography.dart';
import '../../../core/design_system/components/soteria_back_button.dart';
import '../../../core/widgets/glass_surface.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SoteriaPage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'SETTINGS',
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 2.5,
            ),
          ),
          centerTitle: true,
          leadingWidth: 70,
          leading: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Center(
              child: SoteriaBackButton(),
            ),
          ),
        ),
        body: ListView(
          cacheExtent: 1000.0, physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: SoteriaSpacing.containerPadding(context),
            vertical: 24.h,
          ),
          children: [
            RepaintBoundary(
              child: _SettingsSection(
                title: 'ACCOUNT',
                items: [
                  _SettingsItem(
                    icon: Icons.person_rounded,
                    iconColor: const Color(0xFF7C4DFF),
                    title: 'Profile Information',
                    subtitle: 'View and edit your profile details',
                    onTap: () => context.push(SoteriaRoutes.profileInformation),
                  ),
                  const _SettingsDivider(),
                  _SettingsItem(
                    icon: Icons.shield_rounded,
                    iconColor: const Color(0xFF00E5FF),
                    title: 'Security & Password',
                    subtitle: 'Manage your password and security',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SoteriaSpacing.gapMD,
            RepaintBoundary(
              child: _SettingsSection(
                title: 'PREFERENCES',
                items: [
                  _SettingsItem(
                    icon: Icons.notifications_rounded,
                    iconColor: SoteriaColors.gold,
                    title: 'Notifications',
                    subtitle: 'Manage your notification preferences',
                    onTap: () => context.push(SoteriaRoutes.notificationSettings),
                  ),
                  const _SettingsDivider(),
                  _SettingsItem(
                    icon: Icons.palette_rounded,
                    iconColor: const Color(0xFFE91E63),
                    title: 'Theme & Appearance',
                    subtitle: 'Dark Mode',
                    isThemeItem: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SoteriaSpacing.gapMD,
            RepaintBoundary(
              child: _SettingsSection(
                title: 'SUPPORT',
                items: [
                  _SettingsItem(
                    icon: Icons.help_rounded,
                    iconColor: SoteriaColors.secondary,
                    title: 'Help Center',
                    subtitle: 'Get help and support',
                    onTap: () {},
                  ),
                  const _SettingsDivider(),
                  _SettingsItem(
                    icon: Icons.info_rounded,
                    iconColor: Colors.white60,
                    title: 'About Soteria',
                    subtitle: 'App info, terms and more',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SoteriaSpacing.gapXL,
            RepaintBoundary(
              child: _LogoutSection(onTap: () => _showLogoutDialog(context)),
            ),
            SoteriaSpacing.gapSM,
            Center(
              child: Text(
                'You will be logged out of your account.',
                style: context.bodySmall.copyWith(
                  color: SoteriaColors.muted,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + 20.h),
          ],
        ),
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
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              fontSize: 11.sp,
            ),
          ),
        ),
        GlassSurface(
          borderRadius: BorderRadius.circular(24),
          opacity: 0.05,
          padding: EdgeInsets.zero,
          child: Column(children: items),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.isThemeItem = false,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final bool isThemeItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
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
                  Flexible(
                    child: Text(
                      subtitle!,
                      style: context.labelSmall.copyWith(
                        color: SoteriaColors.muted,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : null,
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Colors.white24,
          size: 24,
        ),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

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

class _LogoutSection extends StatelessWidget {
  const _LogoutSection({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassSurface(
        borderRadius: BorderRadius.circular(20),
        opacity: 0.08,
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                SoteriaColors.error.withValues(alpha: 0.1),
                SoteriaColors.error.withValues(alpha: 0.02),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              const Icon(
                Icons.logout_rounded,
                color: SoteriaColors.error,
                size: 20,
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
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
