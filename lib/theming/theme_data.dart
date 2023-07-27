import 'package:democratus/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DemocTheme {
  static ThemeData get mainTheme => ThemeData().copyWith(
      textTheme: GoogleFonts.robotoSlabTextTheme(),
      colorScheme: DemocScheme.scheme,
      useMaterial3: true,
      inputDecorationTheme: WidgetThemes.inputTheme,
      expansionTileTheme: const ExpansionTileThemeData().copyWith(
        shape: Border.all(style: BorderStyle.none, width: 0),
      ));
}

class DemocScheme {
  static ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.grey);
}

class WidgetThemes {
  static InputDecorationTheme get inputTheme =>
      const InputDecorationTheme().copyWith(
          contentPadding: const EdgeInsets.only(bottom: 0),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: DemocScheme.scheme.onBackground)),
          fillColor: DemocScheme.scheme.onBackground,
          hintStyle: TextStyles.hintStyle);
}
