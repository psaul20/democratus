import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeDatabase {
  final String billSummaryPath = 'bill_summary';
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  FirebaseRealtimeDatabase({bool isTest = false}) {
    if (isTest) {
      makeTestDb();
    }
  }

  void makeTestDb() {
    _database.useDatabaseEmulator('127.0.0.1', 9000);
  }

  // get a reference to the database
  Future<String> getSummaryAt(String billId) async {
    DatabaseReference dbRef = _database.ref('$billSummaryPath/$billId');
    final snapshot = await dbRef.get();
    if (snapshot.exists) {
      return snapshot.value as String;
    } else {
      throw Exception('No summary found for $billId');
    }
  }

  Future<void> setSummaryAt(String billId, String summary) async {
    DatabaseReference dbRef = _database.ref('$billSummaryPath/$billId');
    await dbRef.set(summary);
  }
}
