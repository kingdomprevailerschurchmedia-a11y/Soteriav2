import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../player/domain/models/competitive_activity_event.dart';
import '../../../player/presentation/widgets/activity/competitive_activity_card.dart';

class SocialActivityFeed extends ConsumerWidget {
  final List<CompetitiveActivityEvent> activities;

  const SocialActivityFeed({super.key, required this.activities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activities.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            'No recent competitive activity.',
            style: context.bodySmall.copyWith(color: SoteriaColors.muted),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return CompetitiveActivityCard(
          event: activities[index],
          isLast: index == activities.length - 1,
        );
      },
    );
  }
}
