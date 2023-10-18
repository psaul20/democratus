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
    return snapshot.value as String;
  }

  Future<void> setSummaryAt(String billId, String summary) async {
    DatabaseReference dbRef = _database.ref('$billSummaryPath/$billId');
    await dbRef.set(summary);
  }
}
