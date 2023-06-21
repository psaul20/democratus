
//TODO: Finish implementing package list retrieval. Test package search function.
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEMOCRATUS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ProposalsList(),
        child: const MyHomePage(
          title: 'DEMOCRATUS',
        ),
      ),
    );
  }
}
