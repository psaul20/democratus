import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:democratus/db/firebase_realtime_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(testApp);
  FirebaseRealtimeDatabase db = FirebaseRealtimeDatabase(isTest: true);
  group('Firebase Realtime DB tests', () {
    setUpAll(() async {});
    group('Summary storage tests', () {
      test('set summary', () async {
        await db.setSummaryAt('test', 'test summary');
      });
      test('get summary', () async {
        final summary = await db.getSummaryAt('test');
        expect(summary, 'test summary');
      });
    });
  });
}

MaterialApp testApp = const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Text('test'),
    ),
  ),
);
