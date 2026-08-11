import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import '../providers/registration_notifier.dart';

class StepPersonalIdentity extends ConsumerWidget {
  const StepPersonalIdentity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(registrationProvider.notifier);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      children: [
        SizedBox(height: 32.h),
        Text(
          'Personal Identity',
          style: context.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 34.sp,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Tell us a bit about yourself to get started.',
          style: context.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 40.h),
        _buildLabel(context, 'FIRST NAME'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          hintText: 'e.g. Peter',
          prefixIcon: Icons.person_outline_rounded,
          onChanged: (val) => notifier.updatePersonal(first: val),
          autofillHints: const [AutofillHints.givenName],
        ),
        SizedBox(height: 32.h),
        _buildLabel(context, 'LAST NAME'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          hintText: 'e.g. Bamidele',
          prefixIcon: Icons.person_outline_rounded,
          onChanged: (val) => notifier.updatePersonal(last: val),
          autofillHints: const [AutofillHints.familyName],
        ),
        SizedBox(height: 32.h),
        _buildLabel(context, 'DISPLAY NAME (OPTIONAL)'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          hintText: 'How you appear in competitions',
          prefixIcon: Icons.badge_outlined,
          onChanged: (val) => notifier.updatePersonal(display: val),
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: context.labelSmall.copyWith(
        color: Colors.white.withValues(alpha: 0.4),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700,
        fontSize: 12.sp,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String hintText,
    required IconData prefixIcon,
    required ValueChanged<String>? onChanged,
    bool enabled = true,
    Iterable<String>? autofillHints,
  }) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        color: const Color(0xFF130F26).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF5E2BFF).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        enabled: enabled,
        autofillHints: autofillHints,
        style: context.bodyLarge.copyWith(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.2),
            fontSize: 16.sp,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Icon(
              prefixIcon,
              color: const Color(0xFF5E2BFF),
              size: 24.sp,
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 20.h),
        ),
      ),
    );
  }
}
