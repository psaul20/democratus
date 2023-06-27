import 'package:democratus/styles/theme_data.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle get fieldTitle => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get dropDownStyle => TextStyle(
      fontSize: 18, color: DemocTheme.mainTheme.colorScheme.onBackground);
}
