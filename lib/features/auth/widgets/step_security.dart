import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import '../providers/registration_notifier.dart';
import 'password_strength_indicator.dart';

class StepSecurity extends ConsumerStatefulWidget {
  const StepSecurity({super.key});

  @override
  ConsumerState<StepSecurity> createState() => _StepSecurityState();
}

class _StepSecurityState extends ConsumerState<StepSecurity> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registrationProvider);
    final notifier = ref.read(registrationProvider.notifier);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      children: [
        SizedBox(height: 32.h),
        Text(
          'Security',
          style: context.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 34.sp,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Protect your account with a strong password.',
          style: context.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 40.h),
        _buildLabel(context, 'PASSWORD'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          controller: _passwordController,
          hintText: 'Enter secure password',
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: true,
          onChanged: (val) => notifier.updateSecurity(password: val),
          autofillHints: const [AutofillHints.newPassword],
        ),
        SizedBox(height: 16.h),
        PasswordStrengthIndicator(password: state.password),
        SizedBox(height: 32.h),
        _buildLabel(context, 'CONFIRM PASSWORD'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          controller: _confirmController,
          hintText: 'Repeat password',
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: true,
          onChanged: (val) => notifier.updateSecurity(confirm: val),
          autofillHints: const [AutofillHints.newPassword],
        ),
        SizedBox(height: 40.h),
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
    TextEditingController? controller,
    bool obscureText = false,
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
        controller: controller,
        onChanged: onChanged,
        enabled: enabled,
        obscureText: obscureText,
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
