import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/widgets/navigation/soteria_bottom_nav_bar.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      backgroundColor: SoteriaColors.backgroundBottomRight,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: SoteriaColors.backgroundGradient,
            ),
          ),
          navigationShell,
        ],
      ),
      bottomNavigationBar: SoteriaBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }

  void _onTabTapped(BuildContext context, int index) {
    navigationShell.goBranch(index, initialLocation: true);
  }
}
