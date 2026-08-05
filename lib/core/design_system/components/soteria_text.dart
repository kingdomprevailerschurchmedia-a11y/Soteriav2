import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class SoteriaText extends StatelessWidget {
  const SoteriaText.displayLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
  }) : style = null,
       _variant = _TextVariant.displayLarge;
  const SoteriaText.displayMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
  }) : style = null,
       _variant = _TextVariant.displayMedium;
  const SoteriaText.headline(this.text, {super.key, this.color, this.textAlign})
    : style = null,
      _variant = _TextVariant.headline;
  const SoteriaText.title(this.text, {super.key, this.color, this.textAlign})
    : style = null,
      _variant = _TextVariant.title;
  const SoteriaText.body(this.text, {super.key, this.color, this.textAlign})
    : style = null,
      _variant = _TextVariant.body;
  const SoteriaText.label(this.text, {super.key, this.color, this.textAlign})
    : style = null,
      _variant = _TextVariant.label;
  const SoteriaText.caption(this.text, {super.key, this.color, this.textAlign})
    : style = null,
      _variant = _TextVariant.caption;

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextStyle? style;
  final _TextVariant _variant;

  @override
  Widget build(BuildContext context) {
    TextStyle baseStyle;
    switch (_variant) {
      case _TextVariant.displayLarge:
        baseStyle = context.displayLarge;
        break;
      case _TextVariant.displayMedium:
        baseStyle = context.displayMedium;
        break;
      case _TextVariant.headline:
        baseStyle = context.headlineMedium;
        break;
      case _TextVariant.title:
        baseStyle = context.titleLarge;
        break;
      case _TextVariant.body:
        baseStyle = context.bodyLarge;
        break;
      case _TextVariant.label:
        baseStyle = context.labelLarge;
        break;
      case _TextVariant.caption:
        baseStyle = context.bodySmall;
        break;
    }

    return Text(
      text,
      textAlign: textAlign,
      style: baseStyle.copyWith(color: color),
    );
  }
}

enum _TextVariant {
  displayLarge,
  displayMedium,
  headline,
  title,
  body,
  label,
  caption,
}
