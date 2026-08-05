import 'package:flutter/material.dart';
import '../../../core/design_system/colors/soteria_colors.dart';
import '../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../core/design_system/typography/soteria_typography.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoteriaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'SETTINGS',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        children: [
          _SettingsSection(
            title: 'ACCOUNT',
            items: [
              _SettingsItem(
                icon: Icons.person_outline_rounded,
                title: 'Profile Information',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.security_rounded,
                title: 'Security & Password',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xl),
          _SettingsSection(
            title: 'PREFERENCES',
            items: [
              _SettingsItem(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.palette_outlined,
                title: 'Theme & Appearance',
                subtitle: 'Dark Mode',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xl),
          _SettingsSection(
            title: 'SUPPORT',
            items: [
              _SettingsItem(
                icon: Icons.help_outline_rounded,
                title: 'Help Center',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.info_outline_rounded,
                title: 'About Soteria',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          TextButton(
            onPressed: () {},
            child: Text(
              'LOGOUT',
              style: context.bodyMedium.copyWith(
                color: SoteriaColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
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
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Column(children: items),
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
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: context.bodyMedium),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.labelSmall.copyWith(color: SoteriaColors.muted),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: SoteriaColors.muted,
      ),
    );
  }
}
