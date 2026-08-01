import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class PremiumErrorScreen extends StatelessWidget {
  final Object exception;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;
  final bool isUnexpected;

  const PremiumErrorScreen({
    super.key,
    required this.exception,
    this.stackTrace,
    this.onRetry,
    this.isUnexpected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoteriaColors.backgroundBottomRight,
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: SoteriaSpacing.xxl),
                    _ErrorIllustration(isUnexpected: isUnexpected),
                    SizedBox(height: SoteriaSpacing.xxl),
                    Text(
                      isUnexpected ? 'SYSTEM ANOMALY' : 'CONNECTION INTERRUPTED',
                      style: SoteriaTypography.headline.copyWith(
                        color: SoteriaColors.gold,
                        letterSpacing: 2.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SoteriaSpacing.md),
                    Text(
                      isUnexpected
                          ? 'An unexpected error occurred within the secure perimeter. Our engineers have been notified.'
                          : 'We are unable to establish a secure link to the server. Please check your encryption protocols (network).',
                      style: SoteriaTypography.body.copyWith(
                        color: SoteriaColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (onRetry != null) ...[
                      SizedBox(height: SoteriaSpacing.xxl),
                      SoteriaButton(
                        label: 'RE-ESTABLISH CONNECTION',
                        onPressed: onRetry!,
                        isPrimary: true,
                      ),
                    ],
                    SizedBox(height: SoteriaSpacing.xxl),
                    if (isUnexpected)
                      Text(
                        'ERROR_CODE: ${exception.hashCode.toRadixString(16).toUpperCase()}',
                        style: SoteriaTypography.caption.copyWith(
                          color: SoteriaColors.hints,
                          fontFamily: 'monospace',
                        ),
                      ),
                    SizedBox(height: SoteriaSpacing.lg),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorIllustration extends StatelessWidget {
  final bool isUnexpected;
  const _ErrorIllustration({required this.isUnexpected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        color: SoteriaColors.gold.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: SoteriaColors.gold.withValues(alpha: 0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.gold.withValues(alpha: 0.1),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          isUnexpected ? Icons.security_update_warning_rounded : Icons.wifi_off_rounded,
          color: SoteriaColors.gold,
          size: 48.w,
        ),
      ),
    );
  }
}

// Temporary internal button since I don't want to break if someone changes the shared one
class SoteriaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const SoteriaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: isPrimary ? SoteriaColors.primary : Colors.transparent,
          borderRadius: SoteriaRadius.brMd,
          border: isPrimary ? null : Border.all(color: SoteriaColors.border),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: SoteriaColors.primary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: SoteriaTypography.label.copyWith(
              color: SoteriaColors.textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
