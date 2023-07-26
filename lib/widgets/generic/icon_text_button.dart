import 'package:democratus/theming/text_styles.dart';
import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.onPressed,
    this.iconSize = 30.0,
    this.iconColor,
    required this.text,
    this.style,
    required this.icon,
  });

  final double iconSize;
  final Color? iconColor;
  final void Function()? onPressed;
  final String text;
  final TextStyle? style;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    iconColor ?? DemocScheme.scheme.onBackground;
    style ?? TextStyles.iconText;
    return Column(
      children: [
        IconButton(
          icon: icon,
          onPressed: onPressed,
          iconSize: iconSize,
          color: iconColor,
        ),
        Text(text, style: style)
      ],
    );
  }
}
