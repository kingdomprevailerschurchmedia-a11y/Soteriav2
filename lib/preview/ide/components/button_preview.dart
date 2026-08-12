import 'package:flutter/material.dart';
import '../../../core/design_system/components/soteria_button.dart';
import '../preview_scaffold.dart';

void main() {
  runApp(const ButtonPreview());
}

class ButtonPreview extends StatelessWidget {
  const ButtonPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SoteriaButton.primary(label: 'PRIMARY BUTTON', onPressed: () {}),
              const SizedBox(height: 16),
              SoteriaButton.secondary(
                label: 'SECONDARY BUTTON',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              SoteriaButton.outline(label: 'OUTLINE BUTTON', onPressed: () {}),
              const SizedBox(height: 16),
              const SoteriaButton.primary(
                label: 'DISABLED BUTTON',
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
