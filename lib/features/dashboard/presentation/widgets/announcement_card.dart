import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: GlassSurface(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: SoteriaColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.campaign_rounded,
                color: SoteriaColors.primary,
                size: 20,
              ),
            ),
            SizedBox(width: SoteriaSpacing.md),
            Expanded(
              child: Text(
                message,
                style: context.bodyMedium.copyWith(color: Colors.white70),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: SoteriaColors.muted),
          ],
        ),
      ),
    );
  }
}
