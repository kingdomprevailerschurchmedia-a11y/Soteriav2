import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      children: [
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'What is your current ',
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'academic level?',
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: const Color(0xFF7C4DFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 4.h),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFF7C4DFF),
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.lg),
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
