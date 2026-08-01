import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/widgets/cards/soteria_list_tile.dart';

class SoteriaRadioTile<T> extends StatelessWidget {
  const SoteriaRadioTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SoteriaListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Radio<T>(
        // ignore: deprecated_member_use
        value: value,
        // ignore: deprecated_member_use
        groupValue: groupValue,
        // ignore: deprecated_member_use
        onChanged: onChanged,
        activeColor: SoteriaColors.primary,
      ),
      onTap: () => onChanged(value),
    );
  }
}
