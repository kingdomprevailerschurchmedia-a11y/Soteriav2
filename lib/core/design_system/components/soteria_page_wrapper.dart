import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';

class SoteriaPageWrapper extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final bool isScrollable;
  final bool usePadding;

  const SoteriaPageWrapper({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.showAppBar = true,
    this.isScrollable = true,
    this.usePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = body;

    if (usePadding) {
      content = Padding(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: content,
      );
    }

    if (isScrollable) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    return SafeGradientScaffold(
      appBar: showAppBar
          ? AppBar(
              title: title != null ? Text(title!) : null,
              actions: actions,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
            )
          : null,
      floatingActionButton: floatingActionButton,
      body: content,
    );
  }
}
