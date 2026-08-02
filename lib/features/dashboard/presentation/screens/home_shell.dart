import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/widgets/navigation/soteria_bottom_nav_bar.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getTabIndex(location);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: SoteriaColors.backgroundGradient,
        ),
        child: Stack(
          children: [
            child,
            Align(
              alignment: Alignment.bottomCenter,
              child: SoteriaBottomNavBar(
                currentIndex: currentIndex,
                onTap: (index) => _onTabTapped(context, index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getTabIndex(String location) {
    if (location.startsWith('/app/play')) return 1;
    if (location.startsWith('/app/leaderboard')) return 2;
    if (location.startsWith('/app/rewards')) return 3;
    if (location.startsWith('/app/profile')) return 4;
    return 0;
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/app');
      case 1:
        // context.go('/app/play');
        break;
      case 2:
        context.go('/app/leaderboard');
      case 3:
        context.go('/app/wallet');
      case 4:
        context.go('/app/profile');
    }
  }
}
