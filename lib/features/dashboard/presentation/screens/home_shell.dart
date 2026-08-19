import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/soteria_background.dart';
import '../../../../core/widgets/navigation/soteria_bottom_nav_bar.dart';
import '../../../notifications/providers/notification_providers.dart';
import '../../../player/providers/player_providers.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keep providers active
    ref.watch(playerAvatarSyncProvider);
    final unreadCount = ref.watch(unreadCountProvider);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const SoteriaBackground(),
          navigationShell,
        ],
      ),
      bottomNavigationBar: SoteriaBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTabTapped(context, index),
        unreadCount: unreadCount,
      ),
    );
  }

  void _onTabTapped(BuildContext context, int index) {
    navigationShell.goBranch(index, initialLocation: true);
  }
}
