import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import '../models/identity_provider.dart';

enum AuthProviderButtonVariant { glow, outline }

class AuthProviderButton extends StatefulWidget {
  const AuthProviderButton({
    super.key,
    required this.provider,
    required this.onTap,
    this.isLoading = false,
    this.variant = AuthProviderButtonVariant.glow,
  });

  final IdentityProvider provider;
  final VoidCallback onTap;
  final bool isLoading;
  final AuthProviderButtonVariant variant;

  @override
  State<AuthProviderButton> createState() => _AuthProviderButtonState();
}

class _AuthProviderButtonState extends State<AuthProviderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.provider.type == IdentityProviderType.apple &&
        !kIsWeb &&
        !Platform.isIOS) {
      return const SizedBox.shrink();
    }

    final isGoogle = widget.provider.type == IdentityProviderType.google;
    final isEmail = widget.provider.type == IdentityProviderType.email;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.isLoading ? null : widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            height: 64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: const Color(0xFF0D0B1E),
              border: Border.all(
                color:
                    isEmail
                        ? SoteriaColors.primary.withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                if (isGoogle)
                  BoxShadow(
                    color: SoteriaColors.primary.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Center(
              child:
                  widget.isLoading
                      ? _buildLoader()
                      : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SoteriaSpacing.lg,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIcon(),
                            SizedBox(width: 16.w),
                            Flexible(
                              child: Text(
                                widget.provider.name,
                                style: context.titleSmall.copyWith(
                                  color:
                                      isEmail
                                          ? SoteriaColors.secondary
                                          : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (widget.provider.type == IdentityProviderType.google) {
      return Image.network(
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
        width: 24.sp,
        height: 24.sp,
        errorBuilder:
            (_, _, _) =>
                Icon(widget.provider.icon, color: Colors.blue, size: 24.sp),
      );
    }
    return Icon(
      widget.provider.icon,
      color: SoteriaColors.secondary,
      size: 24.sp,
    );
  }

  Widget _buildLoader() {
    return SizedBox(
      height: 24.w,
      width: 24.w,
      child: const CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
