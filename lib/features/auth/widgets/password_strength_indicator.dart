import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/utils/identity_validator.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final strength = IdentityValidator.getPasswordStrength(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(5, (index) {
            final barStrength = (index + 1) * 0.2;
            final isActive = strength >= barStrength;

            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4.h,
                margin: EdgeInsets.only(right: index == 4 ? 0 : 4.w),
                decoration: BoxDecoration(
                  color: isActive
                      ? _getColor(strength)
                      : SoteriaColors.muted.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 4.h,
          children: [
            _RequirementItem(
              label: '8+ chars',
              met: IdentityValidator.hasMinLength(password),
            ),
            _RequirementItem(
              label: 'Uppercase',
              met: IdentityValidator.hasUppercase(password),
            ),
            _RequirementItem(
              label: 'Lowercase',
              met: IdentityValidator.hasLowercase(password),
            ),
            _RequirementItem(
              label: 'Number',
              met: IdentityValidator.hasDigit(password),
            ),
            _RequirementItem(
              label: 'Special',
              met: IdentityValidator.hasSpecialChar(password),
            ),
          ],
        ),
      ],
    );
  }

  Color _getColor(double strength) {
    if (strength <= 0.4) return SoteriaColors.error;
    if (strength <= 0.8) return SoteriaColors.gold;
    return SoteriaColors.success;
  }
}

class _RequirementItem extends StatelessWidget {
  const _RequirementItem({required this.label, required this.met});
  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          met ? Icons.check_circle_rounded : Icons.circle_outlined,
          size: 12.w,
          color: met ? SoteriaColors.success : SoteriaColors.muted,
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: context.bodySmall.copyWith(
            fontSize: 10.sp,
            color: met ? SoteriaColors.textPrimary : SoteriaColors.muted,
          ),
        ),
      ],
    );
  }
}
