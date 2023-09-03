import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/material.dart';

class TextStyles {
  BuildContext context;
  TextStyles(this.context);

  TextStyle get headerStyle =>
      Theme.of(context).textTheme.headlineSmall ?? const TextStyle();
  TextStyle get bodyStyle =>
      Theme.of(context).textTheme.titleMedium ?? const TextStyle();
  TextStyle get appBarStyleAlt =>
      Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: DemocScheme.scheme.onSecondary) ??
      const TextStyle();
  TextStyle get fabTextStyle =>
      Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: DemocScheme.scheme.onBackground) ??
      const TextStyle();
}
