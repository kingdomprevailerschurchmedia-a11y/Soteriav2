import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

import '../../utils/soteria_responsive.dart';

class SoteriaBottomSheet extends StatelessWidget {
  const SoteriaBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.action,
  });

  final String title;
  final Widget child;
  final Widget? action;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    Widget? action,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) =>
          SoteriaBottomSheet(title: title, action: action, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final action = this.action;
    final isShort = SoteriaResponsive.isShortScreen(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(
        color: SoteriaColors.elevatedSurface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: bottomInset > 0 ? bottomInset : safeBottom,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.mdStatic),
            ),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: SoteriaColors.muted.withValues(alpha: 0.3),
                borderRadius: SoteriaRadius.brFull,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style:
                          (isShort ? context.titleMedium : context.titleLarge)
                              .copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  ?action,
                ],
              ),
            ),
            Flexible(child: child),
            SizedBox(
              height: SoteriaSpacing.adaptive(context, SoteriaSpacing.lgStatic),
            ),
          ],
        ),
      ),
    );
  }
}
