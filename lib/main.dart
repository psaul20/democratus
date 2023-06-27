import 'package:democratus/pages/home_page.dart';
import 'package:democratus/styles/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEMOCRATUS',
      theme: DemocTheme.mainTheme,
      home: ChangeNotifierProvider(
        create: (context) => PackageList(),
        child: const MyHomePage(
          title: 'DEMOCRATUS',
        ),
      ),
    );
  }
}
