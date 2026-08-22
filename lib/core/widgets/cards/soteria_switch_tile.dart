import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/widgets/cards/soteria_list_tile.dart';

class SoteriaSwitchTile extends StatelessWidget {
  const SoteriaSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SoteriaListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeTrackColor: SoteriaColors.primary.withValues(alpha: 0.2),
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return SoteriaColors.primary;
          }
          return Colors.white;
        }),
      ),
      onTap: () => onChanged(!value),
    );
  }
}
