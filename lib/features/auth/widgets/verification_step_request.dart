import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_text_field.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import '../models/verification_type.dart';
import '../providers/verification_notifier.dart';

class VerificationStepRequest extends ConsumerWidget {
  const VerificationStepRequest({super.key, required this.type});
  final VerificationType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationProvider(type));
    final notifier = ref.read(verificationProvider(type).notifier);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: type == VerificationType.passwordRecovery
                          ? 'Recover '
                          : 'Verify ',
                      style: context.headlineLarge.copyWith(
                        color: SoteriaColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: type == VerificationType.passwordRecovery
                          ? 'Password'
                          : 'Email',
                      style: context.headlineLarge.copyWith(
                        color: SoteriaColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: SoteriaSpacing.sm),
              Icon(
                type == VerificationType.passwordRecovery
                    ? Icons.lock_reset_rounded
                    : Icons.verified_user_rounded,
                color: SoteriaColors.secondary,
                size: 28.sp,
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xs),
          Text(
            type == VerificationType.passwordRecovery
                ? 'Enter your email to receive a password reset link.'
                : 'Verify your email to secure your account and unlock all features.',
            style: context.bodyMedium,
          ),
          SizedBox(height: SoteriaSpacing.xl),

          // Illustration Box
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: SoteriaRadius.brLg,
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background glow/elements
                    Container(
                      height: 140.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: SoteriaColors.primary.withValues(alpha: 0.2),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    // Illustration Icons
                    Icon(
                      type == VerificationType.passwordRecovery
                          ? Icons.lock_open_rounded
                          : Icons.email_rounded,
                      size: 80.sp,
                      color: SoteriaColors.primary,
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      child: Icon(
                        Icons.lock_outline_rounded,
                        size: 30.sp,
                        color: SoteriaColors.primary.withValues(alpha: 0.5),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 10,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: Icon(
                          Icons.send_rounded,
                          size: 24.sp,
                          color: SoteriaColors.primary.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    // Inner Checkmark
                    Positioned(
                      bottom: 45.h,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: SoteriaColors.background,
                          shape: BoxShape.circle,
                          border: Border.all(color: SoteriaColors.primary),
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 16.sp,
                          color: SoteriaColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SoteriaSpacing.lg),
                // Notice box
                Container(
                  padding: EdgeInsets.all(SoteriaSpacing.md),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: SoteriaRadius.brMd,
                    border: Border.all(
                      color: SoteriaColors.gold.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        color: SoteriaColors.gold,
                        size: 20.sp,
                      ),
                      SizedBox(width: SoteriaSpacing.md),
                      Expanded(
                        child: Text(
                          type == VerificationType.passwordRecovery
                              ? 'We\'ll send a password reset link to the email you provide.'
                              : 'We\'ll send a 6-digit verification code to the email you provide.',
                          style: context.bodySmall.copyWith(
                            color: SoteriaColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: SoteriaSpacing.xl),

          Text(
            'Email Address',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          SoteriaTextField(
            initialValue: state.target,
            hintText: 'name@example.com',
            onChanged: notifier.updateTarget,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            enabled: !state.isLoading,
            prefixIcon: Icons.email_outlined,
          ),
          SizedBox(height: SoteriaSpacing.md),
          Row(
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 14.sp,
                color: SoteriaColors.muted,
              ),
              SizedBox(width: SoteriaSpacing.xs),
              Expanded(
                child: Text(
                  'Your email is safe with us. We never share your information.',
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
