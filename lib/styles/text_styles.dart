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
  static TextStyle get expandedListTile => const TextStyle(fontSize: 12);
  static TextStyle get iconText => const TextStyle(fontSize: 10);
  static TextStyle get titleText =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle get listTileTitle => const TextStyle(
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
      );
}
