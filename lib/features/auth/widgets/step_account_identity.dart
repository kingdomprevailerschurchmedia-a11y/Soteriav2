import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import '../providers/registration_notifier.dart';

class StepAccountIdentity extends ConsumerWidget {
  const StepAccountIdentity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationProvider);
    final notifier = ref.read(registrationProvider.notifier);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        SizedBox(height: 20.h),
        Text(
          'Account Identity',
          style: context.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 40.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Choose a unique username and valid email.',
          style: context.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 40.h),
        _buildLabel(context, 'EMAIL ADDRESS'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          hintText: 'name@example.com',
          prefixIcon: Icons.mail_outline_rounded,
          onChanged: (val) => notifier.updateAccount(email: val),
          keyboardType: TextInputType.emailAddress,
          enabled: !state.isLoading,
        ),
        SizedBox(height: 24.h),
        _buildLabel(context, 'USERNAME'),
        SizedBox(height: 12.h),
        _buildTextField(
          context: context,
          hintText: 'e.g. knowledge_king',
          prefixIcon: Icons.person_outline_rounded,
          onChanged: (val) => notifier.updateAccount(username: val),
          enabled: !state.isLoading,
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: context.labelSmall.copyWith(
        color: Colors.white.withValues(alpha: 0.4),
        letterSpacing: 1.2,
        fontWeight: FontWeight.w500,
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
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0D0B1E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: TextField(
        onChanged: onChanged,
        enabled: enabled,
        keyboardType: keyboardType,
        style: context.bodyLarge.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.bodyLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.2),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: SoteriaColors.secondary,
            size: 24.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }
}
