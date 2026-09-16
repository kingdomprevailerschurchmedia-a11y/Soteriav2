import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/personalization/providers/personalization_notifier.dart';
import 'package:soteria/features/personalization/widgets/selection_card.dart';

class StepAcademicLevel extends ConsumerWidget {
  const StepAcademicLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalizationProvider);
    final notifier = ref.read(personalizationProvider.notifier);

    final options = [
      {
        'title': 'Secondary School',
        'subtitle': 'High school / Secondary education',
        'icon': Icons.school_rounded,
      },
      {
        'title': 'University',
        'subtitle': 'Undergraduate degree',
        'icon': Icons.account_balance_rounded,
      },
      {
        'title': 'Graduate',
        'subtitle': 'Master\'s / Postgraduate',
        'icon': Icons.workspace_premium_rounded,
      },
      {
        'title': 'Professional',
        'subtitle': 'Working professional / Vocational',
        'icon': Icons.business_center_rounded,
      },
      {
        'title': 'General Knowledge',
        'subtitle': 'Lifelong learning / Personal growth',
        'icon': Icons.menu_book_rounded,
      },
    ];

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(height: 40.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'What is your current\n',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 28.sp,
                      color: const Color(0xFF2E1A8A),
                      height: 1.1,
                    ),
                  ),
                  TextSpan(
                    text: 'academic level?',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 28.sp,
                      color: SoteriaColors.gold,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'This helps us personalise your learning\nexperience and recommendations.',
              style: context.bodyLarge.copyWith(
                color: const Color(0xFF2E1A8A).withValues(alpha: 0.6),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...options.map(
          (opt) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: SelectionCard(
              title: opt['title'] as String,
              subtitle: opt['subtitle'] as String,
              icon: opt['icon'] as IconData,
              isSelected: state.academicLevel == opt['title'],
              onTap: () => notifier.setAcademicLevel(opt['title'] as String),
            ),
          ),
        ),
      ],
    );
  }
}
