import 'dart:convert';
import 'dart:io';

import 'package:democratus/api/congress_gov_api.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:democratus/models/bill_models/congress_gov_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  late Response response;
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  setUpAll(() async {
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());

    response = await CongressGovAPI.getBillData(117, 'hr', 3076);
  });
  group('Testing Congress.Gov API', () {
    test('Testing well-formed HTTPS request to Congress.gov', () {
      expect(response.statusCode, 200);
      expect(response.body.isNotEmpty, true);
    });
    test('Testing parsing of JSON response from Congress.gov', () {
      expect(response.body.contains('bill'), true);
      CongressGovBill bill = CongressGovBill.fromJson(
          json.encode(json.decode(response.body)['bill']));
      expect(bill.type, BillType.hr);
      expect(bill.number, 3076);
    });
    test('Testing comparison to example bill', () {
      CongressGovBill bill = CongressGovBill.fromJson(
          json.encode(jsonDecode(response.body)['bill']));
      CongressGovBill exBill = CongressGovBill.fromJson(json.encode(jsonDecode(
          File('test/congress_gov_tests/ref/bill_example.json')
              .readAsStringSync())['bill']));
      expect(bill.type, exBill.type);
      expect(bill.number, exBill.number);
    });
  });
}
