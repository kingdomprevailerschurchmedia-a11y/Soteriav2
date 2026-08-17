import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_text_field.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../../../core/avatar/presentation/widgets/avatar_selection_dialog.dart';
import '../providers/profile_edit_provider.dart';

class ProfileInformationScreen extends ConsumerStatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  ConsumerState<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends ConsumerState<ProfileInformationScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _displayNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  bool _controllersInitialized = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _displayNameController = TextEditingController();
    _usernameController = TextEditingController();
    _bioController = TextEditingController();
  }

  void _initializeControllers(ProfileEditState state) {
    if (_controllersInitialized || !state.isInitialized) return;
    
    _firstNameController.text = state.editedUserProfile?.firstName ?? '';
    _lastNameController.text = state.editedUserProfile?.lastName ?? '';
    _displayNameController.text = state.editedUserProfile?.displayName ?? '';
    _usernameController.text = state.editedUserProfile?.username ?? '';
    _bioController.text = state.editedUserProfile?.bio ?? '';
    _controllersInitialized = true;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _displayNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final state = ref.read(profileEditProvider);
    if (state.hasChanges && !state.isSaved) {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text('You have unsaved changes. Are you sure you want to leave?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('DISCARD'),
            ),
          ],
        ),
      );
      return shouldPop ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileEditProvider);
    final notifier = ref.read(profileEditProvider.notifier);

    _initializeControllers(state);

    ref.listen<bool>(profileEditProvider.select((s) => s.isSaved), (prev, next) {
      if (next == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    });

    ref.listen<String?>(profileEditProvider.select((s) => s.error), (prev, next) {
      if (next != null && next.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.toString()),
            backgroundColor: SoteriaColors.error,
          ),
        );
      }
    });

    return PopScope(
      canPop: !state.hasChanges || state.isSaved,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 60,
          leading: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Center(child: SoteriaBackButton()),
          ),
          title: Text(
            'PROFILE INFORMATION',
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          centerTitle: true,
        ),
        body: !state.isInitialized 
          ? const Center(child: CircularProgressIndicator(color: SoteriaColors.primary))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: SoteriaSpacing.containerPadding(context),
                vertical: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(state),
                  SoteriaSpacing.gapLG,
                  _buildSection(
                    title: 'PERSONAL INFORMATION',
                    children: [
                      SoteriaTextField(
                        label: 'First Name',
                        controller: _firstNameController,
                        onChanged: notifier.updateFirstName,
                        hintText: 'Enter your first name',
                      ),
                      SoteriaSpacing.gapMD,
                      SoteriaTextField(
                        label: 'Last Name',
                        controller: _lastNameController,
                        onChanged: notifier.updateLastName,
                        hintText: 'Enter your last name',
                      ),
                      SoteriaSpacing.gapMD,
                      SoteriaTextField(
                        label: 'Display Name',
                        controller: _displayNameController,
                        onChanged: notifier.updateDisplayName,
                        hintText: 'How others see you',
                      ),
                      SoteriaSpacing.gapMD,
                      SoteriaTextField(
                        label: 'Bio',
                        controller: _bioController,
                        onChanged: notifier.updateBio,
                        hintText: 'Tell others about yourself',
                        keyboardType: TextInputType.multiline,
                      ),
                    ],
                  ),
                  SoteriaSpacing.gapLG,
                  _buildSection(
                    title: 'PUBLIC IDENTITY',
                    children: [
                      SoteriaTextField(
                        label: 'Username',
                        controller: _usernameController,
                        onChanged: notifier.updateUsername,
                        hintText: 'Unique competitive identifier',
                        suffixIcon: state.isUsernameChecking
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              )
                            : state.usernameError != null
                                ? const Icon(Icons.error_outline_rounded, color: SoteriaColors.error)
                                : state.hasChanges && state.editedUserProfile?.username != state.originalUserProfile?.username
                                    ? const Icon(Icons.check_circle_outline_rounded, color: SoteriaColors.success)
                                    : null,
                      ),
                      if (state.usernameError != null) ...[
                        SoteriaSpacing.gapXS,
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            state.usernameError!,
                            style: context.labelSmall.copyWith(color: SoteriaColors.error),
                          ),
                        ),
                      ],
                      SoteriaSpacing.gapSM,
                      Text(
                        'Your username is your unique ID used for matchmaking and social search.',
                        style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                      ),
                    ],
                  ),
                  SoteriaSpacing.gapLG,
                  _buildSection(
                    title: 'ACCOUNT',
                    children: [
                      SoteriaTextField(
                        label: 'Email Address',
                        initialValue: state.accountEmail.isNotEmpty ? state.accountEmail : null,
                        readOnly: true,
                        enabled: false,
                        prefixIcon: Icons.email_rounded,
                      ),
                      SoteriaSpacing.gapSM,
                      Text(
                        'Email is managed through your authentication account settings.',
                        style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                      ),
                    ],
                  ),
                  SoteriaSpacing.gapXL,
                  SoteriaButton(
                    label: 'Save Changes',
                    isLoading: state.isSaving,
                    onPressed: state.canSave ? () => notifier.save() : null,
                  ),
                  SizedBox(height: 120.h + MediaQuery.paddingOf(context).bottom),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildHeader(ProfileEditState state) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => AvatarSelectionDialog.show(context),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                SoteriaAvatar(
                  size: 100.w,
                  hasBorder: true,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: SoteriaColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: SoteriaColors.background, width: 2),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    size: 16.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SoteriaSpacing.gapMD,
          Text(
            state.editedUserProfile?.displayName ?? 'Scholar',
            style: context.headlineSmall.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            '@${state.editedUserProfile?.username ?? 'scholar'}',
            style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        GlassSurface(
          borderRadius: BorderRadius.circular(24.r),
          opacity: 0.05,
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }
}
