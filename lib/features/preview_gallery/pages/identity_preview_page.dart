import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/identity/models/user_session.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/features/player/preview/competitive_identity_previews.dart';

class IdentityPreviewPage extends StatelessWidget {
  const IdentityPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        Text('Competitive Identity', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        const CompetitiveIdentityPreviews(),
        SizedBox(height: SoteriaSpacing.xl),
        Text('Session States', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        const _SessionCard(status: SessionStatus.guest, label: 'Guest Session'),
        const _SessionCard(
          status: SessionStatus.authenticated,
          label: 'Authenticated Session',
        ),
        const _SessionCard(
          status: SessionStatus.expired,
          label: 'Expired Session',
        ),
        const _SessionCard(
          status: SessionStatus.offline,
          label: 'Offline Session',
        ),
        SizedBox(height: SoteriaSpacing.xl),
        Text('User Roles', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: Column(
            children: [
              _RoleRow(
                role: 'Premium User',
                icon: Icons.workspace_premium_rounded,
                color: SoteriaColors.gold,
              ),
              _RoleRow(
                role: 'Moderator',
                icon: Icons.gavel_rounded,
                color: SoteriaColors.primary,
              ),
              _RoleRow(
                role: 'Administrator',
                icon: Icons.admin_panel_settings_rounded,
                color: SoteriaColors.success,
              ),
            ],
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        SoteriaButton.ghost(
          label: 'Logout Simulation',
          onPressed: () => _showLogoutDialog(context),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SoteriaColors.surface,
        title: const Text('Sign Out'),
        content: const Text(
          'Are you sure you want to exit your prestigious session?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          SoteriaButton.primary(
            label: 'Sign Out',
            isFullWidth: false,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final SessionStatus status;
  final String label;
  const _SessionCard({required this.status, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SoteriaCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            _StatusBadge(status: status),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final SessionStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    if (status == SessionStatus.authenticated) color = SoteriaColors.success;
    if (status == SessionStatus.expired) color = SoteriaColors.error;
    if (status == SessionStatus.offline) color = SoteriaColors.gold;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _RoleRow extends StatelessWidget {
  final String role;
  final IconData icon;
  final Color color;
  const _RoleRow({required this.role, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(role),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: SoteriaColors.muted),
        ],
      ),
    );
  }
}
