import 'package:democratus/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DemocTheme {
  static ThemeData get mainTheme => ThemeData(
      colorScheme: DemocScheme.scheme,
      useMaterial3: true,
      fontFamily: "RobotoSlab",
      inputDecorationTheme: WidgetThemes.inputTheme);
}

class DemocScheme {
  static ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.grey);
}

class WidgetThemes {
  static InputDecorationTheme get inputTheme => InputDecorationTheme(
      contentPadding: const EdgeInsets.only(bottom: 0),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: DemocScheme.scheme.onBackground)),
      fillColor: DemocScheme.scheme.onBackground,
      hintStyle: TextStyles.hintStyle);
}
