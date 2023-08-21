import 'dart:convert';
import 'dart:io';
import 'package:democratus/api/congress_gov_search.dart';
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/enums/bill_type.dart';
import 'package:democratus/models/congress_gov_bill/bill.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing Bill Methods', () {
    test('Testing Bill creation from CongressGovSearch', () {
      List<Map<String, dynamic>> csvData = List<Map<String, dynamic>>.from(
          json.decode(File('test/congress_gov_tests/ref/csvDataAsMaps.json')
              .readAsStringSync()));
      List<Bill> bills = [
        for (final Map<String, dynamic> bill in csvData)
          Bill.fromCongressGovSearch(bill)
      ];
      expect(bills.length, 5);
    });
    group('Testing Bill JSON encode/decode', () {
      String billString = File('test/congress_gov_tests/ref/bill_example.json')
          .readAsStringSync();
      Map jsonBill = jsonDecode(billString)['bill'];
      billString = jsonEncode(jsonBill);
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
  });
}
