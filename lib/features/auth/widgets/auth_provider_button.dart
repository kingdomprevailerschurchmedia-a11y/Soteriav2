import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/glass_surface.dart';
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

    final isGlow = widget.variant == AuthProviderButtonVariant.glow;

    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
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
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                if (isGlow)
                  BoxShadow(
                    color: SoteriaColors.primary.withValues(alpha: 0.3),
                    blurRadius: 25,
                    offset: const Offset(0, 8),
                  ),
              ],
            ),
            child: GlassSurface(
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: isGlow
                    ? SoteriaColors.primary.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
              opacity: isGlow ? 0.15 : 0.05,
              child: Stack(
                children: [
                  // Inner Glow for Google Button
                  if (isGlow)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.05),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                  Center(
                    child: widget.isLoading
                        ? _buildLoader()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: SoteriaSpacing.lg,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildIcon(),
                                SizedBox(width: SoteriaSpacing.md),
                                Flexible(
                                  child: Text(
                                    widget.provider.name,
                                    style: context.titleSmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                      fontSize: 18.sp,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (widget.provider.type == IdentityProviderType.google) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
          width: 20.sp,
          height: 20.sp,
          errorBuilder: (_, __, ___) =>
              Icon(widget.provider.icon, color: Colors.blue, size: 20.sp),
        ),
      );
    }
    return Icon(widget.provider.icon, color: Colors.white, size: 24.sp);
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
