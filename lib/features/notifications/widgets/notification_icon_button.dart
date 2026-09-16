import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../providers/notification_providers.dart';
import '../../../../core/navigation/soteria_routes.dart';

class NotificationIconButton extends ConsumerWidget {
  const NotificationIconButton({
    super.key,
    this.size = 44,
    this.iconSize = 22,
  });

  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadCountProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size.r,
          height: size.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
              size: iconSize.sp,
            ),
            onPressed: () => context.push(SoteriaRoutes.notifications),
          ),
        ),
        if (unreadCount > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: SoteriaColors.error,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: (size * 0.36).r,
                minHeight: (size * 0.36).r,
              ),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (size * 0.18).sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
