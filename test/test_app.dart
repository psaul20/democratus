import 'dart:developer';

import 'package:democratus/api/congress_gov_api.dart';

import 'package:democratus/theming/theme_data.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

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
      home: Scaffold(
          body: Center(
        child: ElevatedButton(
          child: Text('Press'),
          onPressed: () {
            Uri uri = CongressGovApi.getSearchUri();
            log(uri.toString());
            launchUrl(uri);
          },
        ),
      )),
    );
  }
}
