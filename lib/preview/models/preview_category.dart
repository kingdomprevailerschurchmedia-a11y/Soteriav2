import 'package:flutter/material.dart';

enum PreviewCategory {
  onboarding('Onboarding', Icons.auto_awesome_motion_rounded),
  auth('Authentication', Icons.login_rounded),
  dashboard('Dashboard', Icons.dashboard_rounded),
  practice('Practice Mode', Icons.school_rounded),
  pro('Pro Mode', Icons.stars_rounded),
  tournament('Tournament Mode', Icons.emoji_events_rounded),
  versus('Versus Mode', Icons.bolt_rounded),
  gameplay('Gameplay', Icons.play_circle_filled_rounded),
  quizData('Quiz Data Pipeline', Icons.data_usage_rounded),
  social('Social & Community', Icons.people_rounded),
  profile('Player Profile', Icons.badge_rounded),
  settings('Settings', Icons.settings_rounded),
  designSystem('Design System', Icons.token_rounded),
  components('Components', Icons.widgets_rounded),
  animations('Animations', Icons.animation_rounded),
  dialogs('Dialogs & Sheets', Icons.copy_all_rounded),
  analytics('Analytics & Insights', Icons.insights_rounded),
  devTools('Developer Tools', Icons.build_circle_outlined);

  final String label;
  final IconData icon;
  const PreviewCategory(this.label, this.icon);
}
