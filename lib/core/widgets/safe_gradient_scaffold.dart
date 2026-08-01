import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';

class SafeGradientScaffold extends StatelessWidget {
  const SafeGradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBodyBehindAppBar = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: SoteriaGradients.primaryBackground,
        ),
        child: SizedBox.expand(
          child: SafeArea(
            child: body,
          ),
        ),
      ),
    );
  }
}
