import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/analytics_enums.dart';

class ModeSelector extends StatelessWidget {
  final PerformanceMode selectedMode;
  final ValueChanged<PerformanceMode> onModeChanged;

  const ModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Row(
        children: PerformanceMode.values.map((mode) {
          final isSelected = selectedMode == mode;
          return Expanded(
            child: GestureDetector(
              onTap: () => onModeChanged(mode),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? SoteriaColors.secondary // Use different color for mode to distinguish from period
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  mode.label,
                  style: SoteriaTypography.labelSmall.copyWith(
                    color: isSelected
                        ? SoteriaColors.textPrimary
                        : SoteriaColors.muted,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
