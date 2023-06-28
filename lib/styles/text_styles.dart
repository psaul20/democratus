import 'package:democratus/styles/theme_data.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle get fieldTitle => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get inputStyle => TextStyle(
      fontSize: 18, color: DemocScheme.scheme.onBackground, height: 1);
  static TextStyle get hintStyle =>
      TextStyle(fontSize: 18, color: DemocScheme.scheme.secondary, height: 0);
}
