import 'dart:io';

import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing Pro Publica Bill', () {
    test('Testing Pro Publica Bill creation from JSON', () {
      String billString = File('test/pro_publica_tests/ref/bill_example.json')
          .readAsStringSync();
      ProPublicaBill bill = ProPublicaBill.fromResponseBody(billString);
      expect(bill.billId, '116-hr-502');
      expect(bill.congress, 116);
    });

    test('Testing Pro Publica Bill creation from bill by subject result', () {
      String billString =
          File('test/pro_publica_tests/ref/bills_by_subject_example.json')
              .readAsStringSync();
      List<ProPublicaBill> bills =
          ProPublicaBill.fromResponseBodyList(billString);
      expect(bills.length, 20);
      expect(bills[0].billId, '115-s-1706');
    });

    test('Testing Pro Publica Bill creation from bill search result', () {
      String billString =
          File('test/pro_publica_tests/ref/bill_search_example.json')
              .readAsStringSync();
      List<ProPublicaBill> bills =
          ProPublicaBill.fromResponseBodyList(billString);
      expect(bills.length, 10);
      expect(bills[0].billId, '113-hr-2739');
    });
  });
}
