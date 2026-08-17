import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SoteriaBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const SoteriaBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (!GoRouter.of(context).canPop() && onTap == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap ?? () => context.pop(),
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 20.r,
        ),
      ),
    );
  }
}
