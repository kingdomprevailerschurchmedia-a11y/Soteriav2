import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.05),
      highlightColor: Colors.white.withValues(alpha: 0.1),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(SoteriaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SoteriaSpacing.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 12,
                      decoration: _boxDecoration,
                    ),
                    SizedBox(height: SoteriaSpacing.sm),
                    Container(
                      width: 180,
                      height: 28,
                      decoration: _boxDecoration,
                    ),
                  ],
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Container(
              width: double.infinity,
              height: 160,
              decoration: _boxDecoration,
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Container(width: 120, height: 12, decoration: _boxDecoration),
            SizedBox(height: SoteriaSpacing.md),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.4,
              children: List.generate(
                4,
                (_) => Container(decoration: _boxDecoration),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
            Container(
              width: double.infinity,
              height: 120,
              decoration: _boxDecoration,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration get _boxDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
  );
}
