import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/avatar/presentation/widgets/soteria_avatar.dart';
import 'package:soteria/core/avatar/presentation/widgets/avatar_frame.dart';
import 'package:soteria/core/avatar/providers/avatar_providers.dart';

class AvatarPlatformPreviewPage extends ConsumerWidget {
  const AvatarPlatformPreviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatars = ref.watch(avatarCatalogProvider).all;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('AVATAR PLATFORM'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(SoteriaSpacing.lg.w),
        children: [
          _buildSectionTitle(context, 'CATALOG PREVIEW'),
          SizedBox(height: SoteriaSpacing.md.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.8,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final avatar = avatars[index];
              return Column(
                children: [
                  SoteriaAvatar(avatar: avatar, size: 64),
                  SizedBox(height: 8.h),
                  Text(
                    avatar.displayName,
                    style: context.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
          SizedBox(height: SoteriaSpacing.xl.h),
          _buildSectionTitle(context, 'FRAME TREATMENTS'),
          SizedBox(height: SoteriaSpacing.md.h),
          Wrap(
            spacing: 20.w,
            runSpacing: 20.h,
            children: [
              _buildAvatarVariant('Default', AvatarFrameStyle.standard),
              _buildAvatarVariant('Purple', AvatarFrameStyle.purple),
              _buildAvatarVariant('Gold', AvatarFrameStyle.gold),
              _buildAvatarVariant('Silver', AvatarFrameStyle.silver),
              _buildAvatarVariant('Bronze', AvatarFrameStyle.bronze),
              _buildAvatarVariant('Premium', AvatarFrameStyle.premium),
              _buildAvatarVariant('Locked', AvatarFrameStyle.locked),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xl.h),
          _buildSectionTitle(context, 'SIZES'),
          SizedBox(height: SoteriaSpacing.md.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildAvatarWithSize('Small', 32),
              SizedBox(width: 16.w),
              _buildAvatarWithSize('Medium', 52),
              SizedBox(width: 16.w),
              _buildAvatarWithSize('Large', 80),
              SizedBox(width: 16.w),
              _buildAvatarWithSize('Giant', 120),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xl.h),
          _buildSectionTitle(context, 'STATES'),
          SizedBox(height: SoteriaSpacing.md.h),
          Row(
            children: [
              Column(
                children: [
                  const SoteriaAvatar(size: 64, isOnline: true),
                  SizedBox(height: 8.h),
                  Text('Online', style: context.labelSmall),
                ],
              ),
              SizedBox(width: 24.w),
              Column(
                children: [
                  const SoteriaAvatar(size: 64, showGlow: true),
                  SizedBox(height: 8.h),
                  Text('Glow', style: context.labelSmall),
                ],
              ),
              SizedBox(width: 24.w),
              Column(
                children: [
                  const SoteriaAvatar(size: 64, isSelected: true),
                  SizedBox(height: 8.h),
                  Text('Selected', style: context.labelSmall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.labelSmall.copyWith(
        color: SoteriaColors.gold,
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAvatarVariant(String label, AvatarFrameStyle style) {
    return Column(
      children: [
        SoteriaAvatar(
          size: 64,
          frameStyle: style,
          showGlow:
              style == AvatarFrameStyle.gold ||
              style == AvatarFrameStyle.premium,
        ),
        SizedBox(height: 8.h),
        Text(label, style: SoteriaTypography.labelSmall),
      ],
    );
  }

  Widget _buildAvatarWithSize(String label, double size) {
    return Column(
      children: [
        SoteriaAvatar(size: size),
        SizedBox(height: 8.h),
        Text(label, style: SoteriaTypography.labelSmall),
      ],
    );
  }
}
