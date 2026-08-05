import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: SoteriaColors.surface,
      highlightColor: SoteriaColors.surface.withValues(alpha: 0.5),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SoteriaSpacing.xxl),
            // Header Skeleton
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonBox(width: 80, height: 12),
                      SizedBox(height: SoteriaSpacing.sm),
                      _SkeletonBox(width: 180, height: 32),
                      SizedBox(height: SoteriaSpacing.sm),
                      _SkeletonBox(width: 120, height: 16),
                    ],
                  ),
                  _SkeletonCircle(size: 52),
                ],
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
            // Hero Card Skeleton
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            // Quick Actions Skeleton
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 80,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => _SkeletonBox(
                  width: double.infinity,
                  height: 80,
                  radius: 20,
                ),
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
            // Section Title Skeleton
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              child: _SkeletonBox(width: 150, height: 24),
            ),
            SizedBox(height: SoteriaSpacing.md),
            // List Item Skeleton
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              child: _SkeletonBox(
                width: double.infinity,
                height: 100,
                radius: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({
    required this.width,
    required this.height,
    this.radius = 8,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _SkeletonCircle extends StatelessWidget {
  const _SkeletonCircle({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
