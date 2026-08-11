import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import '../models/verification_type.dart';
import '../models/verification_state.dart';
import '../providers/verification_notifier.dart';

class VerificationStepSent extends ConsumerWidget {
  const VerificationStepSent({super.key, required this.type});
  final VerificationType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationProvider(type));
    final notifier = ref.read(verificationProvider(type).notifier);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        children: [
          // Illustration Box
          SizedBox(
            height: 220.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background glow
                Container(
                  height: 180.h,
                  width: 180.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: SoteriaColors.primary.withValues(alpha: 0.25),
                        blurRadius: 50,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),
                // Dashed orbital lines (simplified with circles)
                Container(
                  height: 200.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                ),
                // Main Illustration
                Icon(
                  Icons.email_rounded,
                  size: 110.sp,
                  color: SoteriaColors.primary,
                ),
                // Paper/Envelope detail
                Positioned(
                  top: 60.h,
                  child: Container(
                    height: 50.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: SoteriaRadius.brSm,
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: SoteriaColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                // Flying plane
                Positioned(
                  top: 20.h,
                  right: 20.w,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Icon(
                      Icons.send_rounded,
                      size: 40.sp,
                      color: SoteriaColors.primary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                // Shield check
                Positioned(
                  bottom: 50.h,
                  right: 40.w,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: SoteriaColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: SoteriaColors.background,
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      Icons.verified_user_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: SoteriaSpacing.lg),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: type == VerificationType.passwordRecovery
                      ? 'Link '
                      : 'Code ',
                  style: context.displaySmall.copyWith(
                    color: SoteriaColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Sent!',
                  style: context.displaySmall.copyWith(
                    color: SoteriaColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: SoteriaSpacing.md),

          // Star Divider
          Row(
            children: [
              const Expanded(
                child: Divider(
                  color: SoteriaColors.gold,
                  thickness: 0.5,
                  endIndent: 10,
                ),
              ),
              Icon(
                Icons.star_rounded,
                color: SoteriaColors.gold,
                size: 16.sp,
              ),
              const Expanded(
                child: Divider(
                  color: SoteriaColors.gold,
                  thickness: 0.5,
                  indent: 10,
                ),
              ),
            ],
          ),

          SizedBox(height: SoteriaSpacing.lg),

          Text(
            type == VerificationType.emailVerification ||
                    type == VerificationType.passwordRecovery
                ? 'Check your inbox for a verification link sent to:'
                : 'We\'ve sent a 6-digit verification code to:',
            style: context.bodyMedium.copyWith(
              color: SoteriaColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: SoteriaSpacing.xl),

          // Email Display Box
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.md,
              vertical: SoteriaSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: SoteriaRadius.brMd,
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(SoteriaSpacing.xs),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: SoteriaRadius.brSm,
                    border: Border.all(
                      color: SoteriaColors.secondary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Icon(
                    Icons.email_outlined,
                    color: SoteriaColors.secondary,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: SoteriaSpacing.md),
                Expanded(
                  child: Text(
                    state.target,
                    style: context.bodyLarge.copyWith(
                      color: SoteriaColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: state.target));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                  icon: Icon(
                    Icons.copy_rounded,
                    color: SoteriaColors.secondary,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: SoteriaSpacing.xxl),

          // Actions Box
          Container(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: SoteriaRadius.brLg,
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              children: [
                Text(
                  type == VerificationType.passwordRecovery
                      ? 'Didn\'t get the link?'
                      : 'Didn\'t get the email?',
                  style: context.titleSmall.copyWith(
                    color: SoteriaColors.textPrimary,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ActionItem(
                      icon: Icons.mark_as_unread_rounded,
                      label: 'Check Spam',
                      subLabel: 'or Promotions',
                      onTap: () {
                        // Info only
                      },
                    ),
                    _ActionItem(
                      icon: Icons.history_rounded,
                      label: type == VerificationType.passwordRecovery
                          ? 'Resend Link'
                          : 'Resend Email',
                      subLabel: state.countdown > 0
                          ? 'in ${state.countdown}s'
                          : 'Send again',
                      onTap: state.countdown > 0 ? null : notifier.resendCode,
                    ),
                    _ActionItem(
                      icon: Icons.edit_note_rounded,
                      label: 'Change Email',
                      subLabel: 'Update address',
                      onTap: () => notifier.setStep(VerificationStep.request),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final VoidCallback? onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.subLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: isEnabled
                ? SoteriaColors.secondary
                : SoteriaColors.textSecondary,
            size: 28.sp,
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subLabel,
            style: context.bodySmall.copyWith(
              color: label == 'Resend Email' && subLabel.contains('s')
                  ? SoteriaColors.gold
                  : SoteriaColors.textSecondary,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
