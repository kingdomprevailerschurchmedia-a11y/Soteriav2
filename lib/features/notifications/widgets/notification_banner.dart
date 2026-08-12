import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';

class NotificationBanner extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onDismiss;

  const NotificationBanner({
    super.key,
    required this.title,
    required this.body,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        child: SoteriaSlideDown(
          child: GestureDetector(
            onVerticalDragEnd: (_) => onDismiss(),
            onTap: onDismiss,
            child: Container(
              padding: EdgeInsets.all(SoteriaSpacing.md),
              decoration: BoxDecoration(
                color: SoteriaColors.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: SoteriaColors.primary.withValues(alpha: 0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: SoteriaColors.primary.withValues(
                      alpha: 0.1,
                    ),
                    child: const Icon(
                      Icons.notifications_active_rounded,
                      color: SoteriaColors.primary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: SoteriaSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: context.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          body,
                          style: context.bodyMedium.copyWith(
                            color: Colors.white70,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: onDismiss,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
