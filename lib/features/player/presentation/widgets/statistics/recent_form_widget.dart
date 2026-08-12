import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';

class RecentFormWidget extends StatelessWidget {
  final List<String> results; // 'W', 'L'

  const RecentFormWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECENT FORM',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: SoteriaSpacing.sm),
        Row(children: results.map((r) => _buildResultCircle(r)).toList()),
      ],
    );
  }

  Widget _buildResultCircle(String result) {
    final isWin = result == 'W';
    return Container(
      margin: EdgeInsets.only(right: 6.w),
      width: 28.w,
      height: 28.w,
      decoration: BoxDecoration(
        color: (isWin ? SoteriaColors.success : SoteriaColors.error).withValues(
          alpha: 0.1,
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: (isWin ? SoteriaColors.success : SoteriaColors.error)
              .withValues(alpha: 0.3),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        result,
        style: TextStyle(
          color: isWin ? SoteriaColors.success : SoteriaColors.error,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
