import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/config/soteria_breakpoints.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= SoteriaBreakpoints.desktop && desktop != null) {
          return desktop!;
        }
        if (constraints.maxWidth >= SoteriaBreakpoints.tablet && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}
