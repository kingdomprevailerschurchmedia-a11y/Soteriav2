import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService(ref);
});

class NavigationService {
  NavigationService(this.ref);
  final Ref ref;

  GoRouter get _router => ref.read(routerProvider);

  void go(String path, {Object? extra}) => _router.go(path, extra: extra);

  Future<T?> push<T extends Object?>(String path, {Object? extra}) =>
      _router.push<T>(path, extra: extra);

  void replace(String path, {Object? extra}) =>
      _router.replace(path, extra: extra);

  void pop<T extends Object?>([T? result]) => _router.pop(result);

  bool canPop() => _router.canPop();

  void pushReplacement(String path, {Object? extra}) =>
      _router.pushReplacement(path, extra: extra);

  // Helper for dialogs
  Future<T?> showSoteriaDialog<T>({
    required BuildContext context,
    required Widget child,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (context) => child,
    );
  }
}
