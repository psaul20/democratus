import 'dart:convert';
import 'dart:io';
import 'package:democratus/enums/bill_type.dart';
import 'package:democratus/models/congress_gov_bill/bill.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String billString =
      File('test/congress_gov_tests/ref/bill_example.json').readAsStringSync();
  Map jsonBill = jsonDecode(billString)['bill'];
  billString = jsonEncode(jsonBill);
  group('Testing Bill JSON encode/decode', () {
    test('Testing Bill from Json', () {
      Bill bill = Bill.fromJson(billString);
      expect(bill.type, BillType.hr);
      expect(bill.congress, 117);
      expect(bill.number, 3076);
    });
    test('Testing Bill to Json', () {
      Bill bill = Bill.fromJson(billString);
      String json = bill.toJson();
      Bill bill2 = Bill.fromJson(json);
      expect(bill.type, bill2.type);
      expect(bill.congress, bill2.congress);
      expect(bill.number, bill2.number);
    });
  });
}
