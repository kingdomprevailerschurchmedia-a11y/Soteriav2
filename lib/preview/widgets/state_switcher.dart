import 'package:flutter/material.dart';

enum PreviewState {
  loading('Loading', Icons.hourglass_top_rounded),
  success('Success', Icons.check_circle_rounded),
  error('Error', Icons.error_rounded),
  empty('Empty', Icons.inbox_rounded),
  offline('Offline', Icons.wifi_off_rounded);

  final String label;
  final IconData icon;
  const PreviewState(this.label, this.icon);
}

class StateSwitcher extends StatelessWidget {
  final PreviewState current;
  final ValueChanged<PreviewState> onChanged;

  const StateSwitcher({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: PreviewState.values.map((state) {
        final isSelected = state == current;
        return IconButton(
          icon: Icon(
            state.icon,
            color: isSelected ? Colors.blue : Colors.white24,
          ),
          tooltip: state.label,
          onPressed: () => onChanged(state),
        );
      }).toList(),
    );
  }
}
