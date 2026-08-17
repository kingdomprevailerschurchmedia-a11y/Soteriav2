import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/animations/soteria_animations.dart';
import '../../../../../core/design_system/animations/soteria_animation_widgets.dart';

class LobbyHeroHeader extends StatelessWidget {
  final String part1;
  final String part2;
  final String part3;
  final String subtitle;
  final List<Color> part2Gradient;
  final List<Color> part3Gradient;

  const LobbyHeroHeader({
    super.key,
    required this.part1,
    required this.part2,
    required this.part3,
    required this.subtitle,
    this.part2Gradient = const [Color(0xFF7C4DFF), Color(0xFFFF4DFF)],
    this.part3Gradient = const [Color(0xFFFFD700), Color(0xFFFFAB40)],
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaFadeIn(
      duration: SoteriaAnimations.medium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: context.headlineLarge.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                color: Colors.white,
                fontSize: 42.sp,
              ),
              children: [
                TextSpan(text: '$part1 '),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: part2Gradient,
                    ).createShader(bounds),
                    child: Text(
                      '$part2 ',
                      style: context.headlineLarge.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        color: Colors.white,
                        fontSize: 42.sp,
                      ),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: part3Gradient,
                    ).createShader(bounds),
                    child: Text(
                      part3,
                      style: context.headlineLarge.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        color: Colors.white,
                        fontSize: 42.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: context.bodyMedium.copyWith(
              color: Colors.white60,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class LobbyInterestsCard extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final String subtitle;

  const LobbyInterestsCard({
    super.key,
    required this.value,
    required this.onChanged,
    this.title = 'Use My Interests',
    this.subtitle = 'Personalized mix based on your profile',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF2E1A8A), Color(0xFF5B3FD9)],
              ),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: SoteriaColors.gold, size: 20),
          ),
          SizedBox(width: SoteriaSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: context.bodySmall.copyWith(
                    fontSize: 10.sp,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: SoteriaColors.gold,
              inactiveThumbColor: Colors.white60,
              inactiveTrackColor: Colors.white12,
            ),
          ),
        ],
      ),
    );
  }
}

class LobbySectionHeader extends StatelessWidget {
  final String label;
  final IconData icon;

  const LobbySectionHeader({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: SoteriaColors.secondary, size: 18.sp),
        SizedBox(width: 8.w),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: Colors.white,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w900,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}

class LobbyDifficultyCard extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const LobbyDifficultyCard({
    super.key,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? color.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.05),
            width: 2.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.25),
                    blurRadius: 15,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : color.withValues(alpha: 0.4),
              size: 22.sp,
            ),
            SizedBox(height: 6.h),
            Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: context.labelSmall.copyWith(
                color: isSelected ? color : color.withValues(alpha: 0.4),
                fontWeight: FontWeight.w900,
                fontSize: 8.sp,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LobbyAdaptiveToggle extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  const LobbyAdaptiveToggle({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.label = 'ADAPTIVE',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? SoteriaColors.info.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? SoteriaColors.info.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloudy_snowing,
              size: 14.sp,
              color: isSelected ? SoteriaColors.info : Colors.white60,
            ),
            SizedBox(width: 8.w),
            Text(
              label.toUpperCase(),
              style: context.labelSmall.copyWith(
                color: isSelected ? SoteriaColors.info : Colors.white60,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LobbyCategoryCard extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const LobbyCategoryCard({
    super.key,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const color = SoteriaColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? color.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.05),
            width: 1.5.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.25),
                    blurRadius: 10,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.white60,
              size: 20.sp,
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelSmall.copyWith(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  fontSize: 8.sp,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LobbyCountCircle extends StatelessWidget {
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const LobbyCountCircle({
    super.key,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.04),
              border: Border.all(
                color: isSelected ? const Color(0xFF7C4DFF) : Colors.white.withValues(alpha: 0.08),
                width: 2.0,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: context.titleMedium.copyWith(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Qns',
            style: context.labelSmall.copyWith(
              color: isSelected ? const Color(0xFF7C4DFF) : Colors.white24,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class LobbyStartAction extends StatelessWidget {
  final bool enabled;
  final String? error;
  final String label;
  final String helperText;
  final VoidCallback onStart;

  const LobbyStartAction({
    super.key,
    required this.enabled,
    this.error,
    required this.label,
    required this.helperText,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            SoteriaColors.background.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user_outlined, size: 14.sp, color: Colors.white30),
              SizedBox(width: 4.w),
              Text(
                helperText,
                style: context.labelSmall.copyWith(color: Colors.white30, fontSize: 9.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: enabled ? onStart : null,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: enabled ? 1.0 : 0.5,
              child: Container(
                height: 64.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C4DFF), Color(0xFF5B3FD9), Color(0xFF2E1A8A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    const Icon(Icons.bolt_rounded, color: SoteriaColors.gold, size: 28),
                    const Spacer(),
                    Text(
                      label.toUpperCase(),
                      style: context.titleSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 28),
                  ],
                ),
              ),
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                error!,
                textAlign: TextAlign.center,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}
