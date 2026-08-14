import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../design_system/colors/soteria_colors.dart';
import '../../../design_system/spacing/soteria_spacing.dart';
import '../../../design_system/typography/soteria_typography.dart';
import '../../../widgets/glass_surface.dart';
import '../../data/avatar_catalog.dart';
import '../../providers/avatar_providers.dart';
import '../../../identity/providers/identity_providers.dart';

class AvatarSelectionDialog extends ConsumerWidget {
  const AvatarSelectionDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const AvatarSelectionDialog(),
    );
  }

  Future<void> _pickImage(WidgetRef ref, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (image != null) {
      await ref.read(profileProvider.notifier).updateProfilePicture(image);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(avatarCatalogProvider);
    final selectedAvatarId = ref.watch(selectedAvatarIdProvider);
    final isUploading = ref.watch(profileUploadProvider);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0B012A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SoteriaSpacing.lg,
            vertical: SoteriaSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Profile Picture',
                    style: context.headlineSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: _ActionTile(
                      icon: Icons.photo_library_rounded,
                      label: 'Gallery',
                      onTap: isUploading
                          ? () {}
                          : () => _pickImage(ref, ImageSource.gallery),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _ActionTile(
                      icon: Icons.camera_alt_rounded,
                      label: 'Camera',
                      onTap: isUploading
                          ? () {}
                          : () => _pickImage(ref, ImageSource.camera),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                'OR CHOOSE AN AVATAR',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 280.h,
                child: GridView.builder(
                  itemCount: catalog.all.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                  ),
                  itemBuilder: (context, index) {
                    final avatar = catalog.all[index];
                    final isSelected = avatar.id == selectedAvatarId;

                    return GestureDetector(
                      onTap: isUploading
                          ? null
                          : () {
                              ref
                                  .read(profileProvider.notifier)
                                  .updateAvatar(avatar.id);
                              Navigator.pop(context);
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? SoteriaColors.gold
                                : Colors.white.withValues(alpha: 0.1),
                            width: 2.w,
                          ),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: ClipOval(
                          child: Image.asset(
                            avatar.assetPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
        if (isUploading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: SoteriaColors.gold),
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassSurface(
        borderRadius: BorderRadius.circular(16.r),
        opacity: 0.05,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            Icon(icon, color: SoteriaColors.gold, size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              label,
              style: context.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
