import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../domain/models/player_presence.dart';
import '../../providers/presence_providers.dart';

class PlayerPresenceIndicator extends ConsumerWidget {
  final String userId;
  final double size;

  const PlayerPresenceIndicator({
    super.key,
    required this.userId,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenceAsync = ref.watch(playerPresenceProvider(userId));

    return presenceAsync.when(
      data: (presence) {
        if (presence == null || !presence.showOnlineStatus) return const SizedBox.shrink();
        return _buildDot(presence.status);
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildDot(PresenceStatus status) {
    Color color;
    switch (status) {
      case PresenceStatus.online:
        color = SoteriaColors.success;
        break;
      case PresenceStatus.inMatch:
        color = SoteriaColors.primary;
        break;
      case PresenceStatus.recentlyActive:
        color = SoteriaColors.warning;
        break;
      case PresenceStatus.offline:
      case PresenceStatus.unavailable:
        color = SoteriaColors.muted;
        break;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: SoteriaColors.background, width: 2),
        boxShadow: [
          if (status == PresenceStatus.online || status == PresenceStatus.inMatch)
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 4,
              spreadRadius: 1,
            ),
        ],
      ),
    );
  }
}
