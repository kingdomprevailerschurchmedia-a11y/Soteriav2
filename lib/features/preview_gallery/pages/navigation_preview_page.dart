import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/widgets/navigation/soteria_avatar.dart';
import 'package:soteria/core/widgets/navigation/soteria_chip.dart';
import 'package:soteria/core/widgets/typography/soteria_text.dart';

class NavigationPreviewPage extends StatelessWidget {
  const NavigationPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        const SoteriaText.label('AVATARS'),
        SizedBox(height: SoteriaSpacing.md),
        Row(
          children: [
            const SoteriaAvatar(initials: 'JD'),
            SizedBox(width: SoteriaSpacing.md),
            const SoteriaAvatar(initials: 'SK', isGold: true, size: 60),
          ],
        ),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaGroupAvatar(
          initials: ['JD', 'SK', 'AM', 'RB'],
          size: 40,
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('CHIPS'),
        SizedBox(height: SoteriaSpacing.md),
        Wrap(
          spacing: SoteriaSpacing.smStatic,
          runSpacing: SoteriaSpacing.smStatic,
          children: [
            const SoteriaChip(label: 'All Topics', isSelected: true),
            SoteriaChip(label: 'History', onTap: () {}),
            SoteriaChip(label: 'Science', onTap: () {}),
            SoteriaChip(label: 'Art', icon: Icons.palette_outlined, onTap: () {}),
          ],
        ),
      ],
    );
  }
}
