import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class SoteriaShimmer extends StatelessWidget {
  const SoteriaShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final double width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: SoteriaColors.surface,
      highlightColor: SoteriaColors.elevatedSurface,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? SoteriaRadius.brMd,
        ),
      ),
    );
  }
}
