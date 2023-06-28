import 'package:democratus/models/saved_packages.dart';
import 'package:democratus/pages/home_page.dart';
import 'package:democratus/providers/logger.dart';
import 'package:democratus/styles/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'models/package.dart';

// TODO: Find better homes for providers
// TODO: Better to use async provider?
final savedPackagesProvider =
    StateNotifierProvider<SavedPackages, List<Package>>(
  (ref) => SavedPackages(),
);

void main() {
  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEMOCRATUS',
      theme: DemocTheme.mainTheme,
      home: const MyHomePage(
        title: 'DEMOCRATUS',
      ),
    );
  }
}
