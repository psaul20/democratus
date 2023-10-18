import 'package:democratus/blocs/summary_bloc/summary_bloc.dart';
import 'package:democratus/db/firebase_realtime_database.dart';
import 'package:democratus/models/bill_models/gen_ai_summary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (context) => SummaryBloc(db: FirebaseRealtimeDatabase()),
    child: const TestApp(),
  ));
}

class TestApp extends StatelessWidget {
  const TestApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void testFunction() => summaryStorageTest(context);

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

void dbTest() async {
  FirebaseRealtimeDatabase db = FirebaseRealtimeDatabase();
  db.setSummaryAt('test', 'test summary');
  String string = await db.getSummaryAt('test');
  assert(string == 'test summary');
}

void summaryStorageTest(BuildContext context) async {
  //This is not working in test app
  GenAiSummary summary = await GenAiSummary.getExampleSummary();
  BlocProvider.of<SummaryBloc>(context).add(GetSummary(summary));
}
