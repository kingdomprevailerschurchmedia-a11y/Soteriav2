import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/animations/soteria_animations.dart';
import '../models/verification_type.dart';
import '../providers/verification_notifier.dart';

class VerificationStepSent extends ConsumerWidget {
  const VerificationStepSent({super.key, required this.type});
  final VerificationType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
<<<<<<< HEAD
    final state = ref.watch(verificationProvider);
=======
    final state = ref.watch(verificationProvider(type));
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30

    return Center(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SoteriaScaleIn(
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SoteriaColors.primary.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.mark_email_read_rounded,
                  size: 80.w,
                  color: SoteriaColors.primary,
                ),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            Text(
              'Code Sent!',
<<<<<<< HEAD
              style: context.headlineMedium.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              state.type == VerificationType.emailVerification || 
              state.type == VerificationType.passwordRecovery
                ? 'Check your inbox for a verification link sent to:'
                : 'We\'ve sent a 6-digit verification code to:',
              style: context.bodyMedium.copyWith(
                color: SoteriaColors.textSecondary,
              ),
=======
              style: context.headlineMedium.copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'We\'ve sent a 6-digit verification code to:',
              style: context.bodyMedium.copyWith(color: SoteriaColors.textSecondary),
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.sm),
            Text(
              state.target,
<<<<<<< HEAD
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
=======
              style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
>>>>>>> 8f919d77a7dfbd609e3794dbbd737ef063400a30
            ),
          ],
        ),
      ),
    );
  }
}
