import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';

class SoteriaAvatar extends StatelessWidget {
  const SoteriaAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.isGold = false,
  });

  final String? imageUrl;
  final String? initials;
  final double size;
  final bool isGold;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isGold ? SoteriaColors.gold : SoteriaColors.primary,
          width: 2,
        ),
        image: imageUrl != null 
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover) 
            : null,
        color: SoteriaColors.surface,
      ),
      alignment: Alignment.center,
      child: imageUrl == null && initials != null
          ? Text(
              initials!.toUpperCase(),
              style: context.labelLarge.copyWith(
                color: isGold ? SoteriaColors.gold : SoteriaColors.textPrimary,
                fontSize: size * 0.4,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }
}

class SoteriaGroupAvatar extends StatelessWidget {
  const SoteriaGroupAvatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.maxAvatars = 3,
  });

  final List<String> initials;
  final double size;
  final int maxAvatars;

  @override
  Widget build(BuildContext context) {
    final avatarsToShow = initials.take(maxAvatars).toList();
    final remaining = initials.length - maxAvatars;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size,
          width: size + (avatarsToShow.length - 1) * (size * 0.6),
          child: Stack(
            children: [
              for (int i = 0; i < avatarsToShow.length; i++)
                Positioned(
                  left: i * (size * 0.6),
                  child: SoteriaAvatar(
                    initials: avatarsToShow[i],
                    size: size,
                  ),
                ),
            ],
          ),
        ),
        if (remaining > 0) ...[
          const SizedBox(width: SoteriaSpacing.smStatic),
          Text(
            '+$remaining',
            style: context.bodySmall.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }
}
