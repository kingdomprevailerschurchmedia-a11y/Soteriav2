import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../providers/logout_notifier.dart';

class LogoutConfirmationDialog extends ConsumerWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(logoutNotifierProvider);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: SoteriaColors.surface.withValues(alpha: 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        title: Row(
          children: [
            const Icon(Icons.logout_rounded, color: SoteriaColors.error),
            SizedBox(width: SoteriaSpacing.sm),
            Text(
              'Log Out',
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to sign out of your account?',
              style: context.bodyMedium.copyWith(
                color: SoteriaColors.textSecondary,
              ),
            ),
            if (logoutState.status == LogoutStatus.failure) ...[
              SizedBox(height: SoteriaSpacing.md),
              Text(
                logoutState.errorMessage ?? 'Logout failed',
                style: context.bodySmall.copyWith(color: SoteriaColors.error),
              ),
            ],
          ],
        ),
        actionsPadding: EdgeInsets.all(SoteriaSpacing.lg),
        actions: [
          Row(
            children: [
              Expanded(
                child: SoteriaButton.ghost(
                  label: 'CANCEL',
                  onPressed: logoutState.status == LogoutStatus.loading
                      ? null
                      : () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: SoteriaButton(
                  label: 'LOG OUT',
                  variant: SoteriaButtonVariant.danger,
                  isLoading: logoutState.status == LogoutStatus.loading,
                  onPressed: () async {
                    await ref.read(logoutNotifierProvider.notifier).logout();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
