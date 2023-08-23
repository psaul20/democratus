import 'dart:convert';
import 'dart:io';

import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing Pro Publica Bill', () {
    test('Testing Pro Publica Bill creation from JSON', () {
      String billString = File('test/pro_publica_tests/ref/bill_example.json')
          .readAsStringSync();
      ProPublicaBill bill =
          ProPublicaBill.fromMap(jsonDecode(billString)['results'][0]);
      expect(bill.billId, 'hr502-116');
      expect(bill.congress, 116);
    });

    test('Testing Pro Publica Bill creation from bill by subject result', () {
      String billString =
          File('test/pro_publica_tests/ref/bills_by_subject_example.json')
              .readAsStringSync();
      List<ProPublicaBill> bills = [];
      for (final Map<String, dynamic> bill
          in jsonDecode(billString)['results']) {
        bills.add(ProPublicaBill.fromMap(bill));
      }
      expect(bills.length, 20);
      expect(bills[0].billId, 's1706-115');
    });
  });
}
