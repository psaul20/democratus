import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:democratus/db/firebase_realtime_database.dart';
import 'package:integration_test/integration_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  group('Firebase Realtime DB tests', () {
    FirebaseRealtimeDatabase db = FirebaseRealtimeDatabase(isTest: true);

    setUpAll(() async {});
    testWidgets('set summary', (WidgetTester tester) async {
      await db.setSummaryAt('test', 'test summary');
      final summary = await db.getSummaryAt('test');
      expect(summary, 'test summary');
    });
  });

  // testWidgets('get summary', (WidgetTester tester) async {

  // });
  // group('Firebase Realtime DB tests', () {
  //   setUpAll(() async {});
  //   groupWidgets('Summary storage tests', () {

  //   });
  // });
}
