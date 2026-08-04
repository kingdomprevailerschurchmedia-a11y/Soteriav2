import 'package:flutter/material.dart';

enum DestinationType { tab, screen, overlay }

class AppDestination {
  final String label;
  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final bool requiresAuth;
  final String? featureFlag;
  final DestinationType type;

  const AppDestination({
    required this.label,
    required this.path,
    required this.icon,
    IconData? selectedIcon,
    this.requiresAuth = true,
    this.featureFlag,
    this.type = DestinationType.screen,
  }) : selectedIcon = selectedIcon ?? icon;

  static const List<AppDestination> tabs = [
    AppDestination(
      label: 'Home',
      path: '/app',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_filled,
      type: DestinationType.tab,
    ),
    AppDestination(
      label: 'Play',
      path: '/app/play',
      icon: Icons.play_circle_outline_rounded,
      selectedIcon: Icons.play_circle_filled_rounded,
      type: DestinationType.tab,
    ),
    AppDestination(
      label: 'Leaderboard',
      path: '/app/leaderboard',
      icon: Icons.leaderboard_outlined,
      selectedIcon: Icons.leaderboard_rounded,
      type: DestinationType.tab,
    ),
    AppDestination(
      label: 'Rewards',
      path: '/app/wallet',
      icon: Icons.stars_outlined,
      selectedIcon: Icons.stars_rounded,
      type: DestinationType.tab,
    ),
    AppDestination(
      label: 'Profile',
      path: '/app/profile',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      type: DestinationType.tab,
    ),
  ];
}
