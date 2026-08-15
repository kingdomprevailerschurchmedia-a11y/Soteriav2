import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../design_system/colors/soteria_colors.dart';
import '../../../design_system/typography/soteria_typography.dart';
import '../../../widgets/safe_gradient_scaffold.dart';
import '../../providers/avatar_providers.dart';
import '../widgets/soteria_avatar.dart';
import '../../../identity/providers/identity_providers.dart';

class AvatarSelectionScreen extends ConsumerWidget {
  const AvatarSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatars = ref.watch(avatarCatalogProvider).all;
    final selectedAvatarId = ref.watch(selectedAvatarIdProvider);
    final profile = ref.watch(profileProvider);
    final isProfileLoading = profile == null;

    return SafeGradientScaffold(
      appBar: AppBar(
        title: Text(
          'Choose Your Avatar',
          style: SoteriaTypography.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: GridView.builder(
          padding: EdgeInsets.only(top: 24.h, bottom: 40.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 24.h,
            childAspectRatio: 0.8,
          ),
          itemCount: avatars.length,
          itemBuilder: (context, index) {
            final avatar = avatars[index];
            final isSelected = avatar.id == selectedAvatarId;
            final isLocked = !avatar.isUnlocked;

            return GestureDetector(
              onTap: (isLocked || isProfileLoading)
                  ? null
                  : () {
                      ref
                          .read(profileProvider.notifier)
                          .updateAvatar(avatar.id);
                      Navigator.of(context).pop();
                    },
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SoteriaAvatar(
                        avatar: avatar,
                        size: 80,
                        isSelected: isSelected,
                        showGlow: isSelected,
                      ),
                      if (isLocked)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.lock_rounded,
                              color: Colors.white,
                              size: 24.w,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    avatar.displayName,
                    style: SoteriaTypography.labelMedium.copyWith(
                      color: isSelected
                          ? SoteriaColors.primary
                          : SoteriaColors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
