import 'package:flutter/material.dart';
import '../../shared/widgets/soteria_background.dart';

class SafeGradientScaffold extends StatelessWidget {
  const SafeGradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBodyBehindAppBar = true,
    this.applySafeArea = true,
    this.backgroundImage,
    this.showBackgroundOverlay = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBodyBehindAppBar;
  final bool applySafeArea;
  final String? backgroundImage;
  final bool showBackgroundOverlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          SoteriaBackground(
            imagePath: backgroundImage ?? 'assets/images/dashboard_bg.png',
            showOverlay: showBackgroundOverlay,
          ),
          if (applySafeArea) SafeArea(child: body) else body,
        ],
      ),
    );
  }
}
