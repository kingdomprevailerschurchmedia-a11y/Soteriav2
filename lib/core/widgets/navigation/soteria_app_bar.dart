import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';

class SoteriaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SoteriaAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.isTransparent = true,
    this.isGradient = false,
    this.centerTitle = true,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool isTransparent;
  final bool isGradient;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: isTransparent ? Colors.transparent : SoteriaColors.navigation,
      elevation: 0,
      flexibleSpace: isGradient 
          ? Container(
              decoration: const BoxDecoration(
                gradient: SoteriaGradients.primaryBackground,
              ),
            ) 
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
