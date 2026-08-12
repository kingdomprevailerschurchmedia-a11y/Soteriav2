import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import '../../domain/avatar.dart';
import 'soteria_avatar.dart';

class SoteriaGroupAvatar extends StatelessWidget {
  const SoteriaGroupAvatar({
    super.key,
    this.avatars,
    this.initials,
    this.size = 40,
    this.maxAvatars = 3,
  });

  final List<Avatar>? avatars;
  final List<String>? initials;
  final double size;
  final int maxAvatars;

  @override
  Widget build(BuildContext context) {
    final count = avatars?.length ?? initials?.length ?? 0;
    if (count == 0) return const SizedBox.shrink();

    final itemsToShow = avatars != null
        ? avatars!.take(maxAvatars).toList()
        : initials!.take(maxAvatars).toList();

    final remaining = count - maxAvatars;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size.w,
          width: (size + (itemsToShow.length - 1) * (size * 0.6)).w,
          child: Stack(
            children: [
              for (int i = 0; i < itemsToShow.length; i++)
                Positioned(
                  left: (i * (size * 0.6)).w,
                  child: itemsToShow[i] is Avatar
                      ? SoteriaAvatar(
                          avatar: itemsToShow[i] as Avatar,
                          size: size,
                        )
                      : _InitialsAvatar(
                          initials: itemsToShow[i] as String,
                          size: size,
                        ),
                ),
            ],
          ),
        ),
        if (remaining > 0) ...[
          SizedBox(width: SoteriaSpacing.sm.w),
          Text(
            '+$remaining',
            style: context.bodySmall.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  final String initials;
  final double size;

  const _InitialsAvatar({required this.initials, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          width: 2.w,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initials.toUpperCase(),
        style: context.labelLarge.copyWith(
          fontSize: (size * 0.4).sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
