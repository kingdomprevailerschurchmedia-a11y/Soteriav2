import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/ambient_glow.dart';

import '../../../../core/utils/soteria_responsive.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
    this.titleWidget,
    this.backgroundGlowColor,
    this.offset = 0.0,
    this.illustrationScale = 1.0,
  });

  final String title;
  final String description;
  final Widget illustration;
  final Widget? titleWidget;
  final Color? backgroundGlowColor;
  final double offset;
  final double illustrationScale;

  @override
  Widget build(BuildContext context) {
    final isShort = SoteriaResponsive.isShortScreen(context);
    final isTablet = SoteriaResponsive.isTablet(context);

    return Stack(
      children: [
        if (backgroundGlowColor != null)
          Positioned(
            top: -100.h,
            right: -100.w,
            child: AmbientGlow(
              color: backgroundGlowColor!.withValues(alpha: 0.1),
              size: 500.w,
              blur: 120,
            ),
          ),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight;
            final maxWidth = constraints.maxWidth;
            final isLandscape = maxWidth > maxHeight;

            // Content width constraint for tablets
            final contentWidth = isTablet ? 500.0 : maxWidth;

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SoteriaSpacing.containerPadding(context),
                  ),
                  child: Column(
                    children: [
                      // Top Spacing
                      if (isLandscape)
                        SizedBox(height: 16.h)
                      else
                        const Spacer(flex: 2),

                      // Illustration Area
                      Flexible(
                        flex: isLandscape ? 4 : 8,
                        child: Transform.translate(
                          offset: Offset(offset * 100, 0),
                          child: AnimatedScale(
                            scale: 1.0 - (offset.abs() * 0.15),
                            duration: const Duration(milliseconds: 400),
                            child: AnimatedOpacity(
                              opacity: 1.0 - (offset.abs() * 0.6),
                              duration: const Duration(milliseconds: 400),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: isLandscape
                                      ? maxHeight * 0.3
                                      : maxHeight * 0.45,
                                  maxWidth: isLandscape
                                      ? contentWidth * 0.4
                                      : contentWidth * 0.85,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24.r),
                                    child: Transform.scale(
                                      scale: illustrationScale,
                                      child: illustration,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Spacing between Illustration and Text
                      if (isLandscape)
                        SizedBox(height: 12.h)
                      else
                        SizedBox(height: 16.h),

                      // Text Content
                      Transform.translate(
                        offset: Offset(offset * 60, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (titleWidget != null)
                              titleWidget!
                            else
                              Text(
                                title,
                                style:
                                    (isShort
                                            ? context.headlineLarge
                                            : context.displayMedium)
                                        .copyWith(
                                          color: SoteriaColors.textPrimary,
                                          height: 1.1,
                                          fontWeight: FontWeight.w900,
                                        ),
                                textAlign: TextAlign.center,
                              ),
                            SizedBox(
                              height: isLandscape ? 8.h : SoteriaSpacing.md,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                description,
                                style:
                                    (isShort || isLandscape
                                            ? context.bodyMedium
                                            : context.bodyLarge)
                                        .copyWith(
                                          color: SoteriaColors.textSecondary,
                                          height: 1.6,
                                        ),
                                textAlign: TextAlign.center,
                                maxLines: isLandscape ? 2 : 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Bottom Spacing for Controls
                      if (isLandscape)
                        SizedBox(height: 16.h)
                      else if (isShort)
                        SizedBox(height: 120.h)
                      else
                        SizedBox(height: 180.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
