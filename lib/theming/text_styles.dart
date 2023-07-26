import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle get fieldTitle => const TextStyle().copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get inputStyle => const TextStyle().copyWith(
      fontSize: 18, color: DemocScheme.scheme.onBackground, height: 1);
  static TextStyle get hintStyle => const TextStyle()
      .copyWith(fontSize: 18, color: DemocScheme.scheme.secondary, height: 0);
  static TextStyle get expandedListTile =>
      const TextStyle().copyWith(fontSize: 12);
  static TextStyle get iconText => const TextStyle().copyWith(fontSize: 8);
  static TextStyle get titleText =>
      const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle get listTileTitle => const TextStyle().copyWith(
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
      );
  static TextStyle get errorText =>
      const TextStyle().copyWith(color: DemocScheme.scheme.error);
}
