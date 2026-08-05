import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:soteria/core/logging/logger_service.dart';

class NavigationCoordinator {
  final GoRouter _router;

  NavigationCoordinator(this._router);

  void navigateTo(String path, {Object? extra}) {
    LoggerService.i('Navigating to: $path', feature: 'Navigation');
    HapticFeedback.lightImpact();
    _router.push(path, extra: extra);
  }

  void go(String path, {Object? extra}) {
    LoggerService.i('Routing to (go): $path', feature: 'Navigation');
    HapticFeedback.selectionClick();
    _router.go(path, extra: extra);
  }

  void pop() {
    if (_router.canPop()) {
      _router.pop();
    }
  }

  void openNotifications() {
    navigateTo('/notifications');
  }

  void openSettings() {
    navigateTo('/app/settings');
  }

  void playPractice() {
    navigateTo('/app/practice');
  }

  void playProMode() {
    navigateTo('/app/pro-mode');
  }

  void playVersus() {
    navigateTo('/app/versus');
  }

  void playTournament() {
    navigateTo('/app/tournaments');
  }
}
