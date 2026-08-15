import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:intl/intl.dart';

class DailyEngagementCalendar extends StatelessWidget {
  final List<String> engagedDates; // YYYY-MM-DD
  final String timezone;

  const DailyEngagementCalendar({
    super.key,
    required this.engagedDates,
    required this.timezone,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Get last 7 days including today
    final last7Days = List.generate(7, (index) {
      return now.subtract(Duration(days: 6 - index));
    });

    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withValues(alpha: 0.5),
        borderRadius: SoteriaRadius.brMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Activity',
            style: context.labelMedium.copyWith(color: SoteriaColors.textSecondary),
          ),
          SizedBox(height: SoteriaSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: last7Days.map((date) {
              final dateStr = DateFormat('yyyy-MM-dd').format(date);
              final isEngaged = engagedDates.contains(dateStr);
              final isToday = DateFormat('yyyy-MM-dd').format(now) == dateStr;

              return Column(
                children: [
                  Text(
                    DateFormat('E').format(date).substring(0, 1),
                    style: context.labelSmall.copyWith(
                      color: isToday ? SoteriaColors.primary : SoteriaColors.muted,
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.xs),
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: isEngaged 
                          ? SoteriaColors.primary.withValues(alpha: 0.2)
                          : SoteriaColors.muted.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isEngaged 
                            ? SoteriaColors.primary 
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isEngaged 
                          ? Icon(Icons.check, size: 16.sp, color: SoteriaColors.primary)
                          : Text(
                              date.day.toString(),
                              style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                            ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
