import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/widgets/cards/soteria_glass_card.dart';
import 'package:soteria/core/widgets/cards/soteria_list_tile.dart';
import 'package:soteria/core/widgets/cards/soteria_switch_tile.dart';
import 'package:soteria/core/widgets/cards/soteria_radio_tile.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';

class CardsPreviewPage extends StatelessWidget {
  const CardsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      children: [
        const SoteriaText.label('STANDARD CARD'),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaCard(
          child: SoteriaText.body('This is a standard Soteria surface.'),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('GLASS CARD'),
        SizedBox(height: SoteriaSpacing.md),
        const SoteriaGlassCard(
          child: SoteriaText.body('Premium glassmorphism surface.'),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('LIST TILES'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaListTile(
          title: 'Account Settings',
          subtitle: 'Manage your profile and security',
          leading: const Icon(Icons.person_outline_rounded),
          onTap: () {},
        ),
        SoteriaListTile(
          title: 'Notifications',
          subtitle: 'Customize your alerts',
          leading: const Icon(Icons.notifications_none_rounded),
          isGlass: true,
          onTap: () {},
        ),
        SizedBox(height: SoteriaSpacing.xl),
        const SoteriaText.label('SPECIALIZED TILES'),
        SizedBox(height: SoteriaSpacing.md),
        SoteriaSwitchTile(
          title: 'Push Notifications',
          subtitle: 'Enable or disable push alerts',
          value: true,
          onChanged: (val) {},
        ),
        SoteriaRadioTile<int>(
          title: 'Standard Difficulty',
          value: 1,
          groupValue: 1,
          onChanged: (val) {},
        ),
        SoteriaRadioTile<int>(
          title: 'Hard Difficulty',
          value: 2,
          groupValue: 1,
          onChanged: (val) {},
        ),
      ],
    );
  }
}
