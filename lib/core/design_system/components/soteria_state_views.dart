import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';

class SoteriaLoadingView extends StatelessWidget {
  const SoteriaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(SoteriaColors.primary),
            strokeWidth: 3,
          ),
          SizedBox(height: SoteriaSpacing.lg),
          Text(
            'SYNCHRONIZING...',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SoteriaEmptyView extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SoteriaEmptyView({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(SoteriaSpacing.xl),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64.sp,
                color: SoteriaColors.muted.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Text(
              title,
              style: context.headlineSmall.copyWith(
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              message,
              style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: SoteriaSpacing.xl),
              SoteriaButton(
                label: actionLabel!,
                onPressed: onAction,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SoteriaOfflineView extends StatelessWidget {
  final VoidCallback onRetry;

  const SoteriaOfflineView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SoteriaEmptyView(
      title: 'CONNECTION LOST',
      message:
          'You are currently offline. Some features may be unavailable until you reconnect.',
      icon: Icons.wifi_off_rounded,
      actionLabel: 'RETRY CONNECTION',
      onAction: onRetry,
    );
  }
}
