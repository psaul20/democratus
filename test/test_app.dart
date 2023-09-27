import 'package:democratus/db/firebase_realtime_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void testFunction() async {
      FirebaseRealtimeDatabase db = FirebaseRealtimeDatabase();
      db.setSummaryAt('test', 'test summary');
      String string = await db.getSummaryAt('test');
      assert(string == 'test summary');
    }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('My First App'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: testFunction,
        child: const Text('Click'),
        backgroundColor: Colors.red[600],
      ),
    ));
  }
}
