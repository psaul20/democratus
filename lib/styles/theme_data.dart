import 'package:flutter/material.dart';

class DemocTheme {
  static ThemeData get mainTheme => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      useMaterial3: true,
      fontFamily: "RobotoSlab");
}
