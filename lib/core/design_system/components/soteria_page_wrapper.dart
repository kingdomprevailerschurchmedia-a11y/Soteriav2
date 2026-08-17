import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/components/soteria_back_button.dart';

class SoteriaPageWrapper extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final bool isScrollable;
  final bool usePadding;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const SoteriaPageWrapper({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.showAppBar = true,
    this.isScrollable = true,
    this.usePadding = true,
    this.physics,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = body;

    if (usePadding) {
      content = Padding(
        padding:
            padding ??
            EdgeInsets.symmetric(
              horizontal: SoteriaSpacing.containerPadding(context),
            ),
        child: content,
      );
    }

    if (isScrollable) {
      content = SingleChildScrollView(
        physics: physics ?? const BouncingScrollPhysics(),
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
              leadingWidth: 60,
              leading: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Center(child: SoteriaBackButton()),
              ),
            )
          : null,
      floatingActionButton: floatingActionButton,
      body: content,
    );
  }
}
