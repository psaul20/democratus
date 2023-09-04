import 'dart:io';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/govinfo_bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  Client client = Client();
  setUpAll(() => dotenv.testLoad(fileInput: File('.env').readAsStringSync()));
  group('Testing Pro Publica Bill', () {
    test('Testing Pro Publica Bill creation from JSON', () {
      String billString =
          File('${Strings.billFilePath}/pro_publica_bill_example.json')
              .readAsStringSync();
      ProPublicaBill bill = ProPublicaBill.fromResponseBody(billString);
      expect(bill.billId, '116-hr-502');
      expect(bill.congress, 116);
    });

    test('Testing Pro Publica Bill creation from bill by subject result', () {
      String billString = File(
              '${Strings.billFilePath}/pro_publica_bills_by_subject_example.json')
          .readAsStringSync();
      List<ProPublicaBill> bills =
          ProPublicaBill.fromResponseBodyList(billString);
      expect(bills.length, 20);
      expect(bills[0].billId, '115-s-1706');
    });

    test('Testing Pro Publica Bill creation from bill search result', () {
      String billString =
          File('${Strings.billFilePath}/pro_publica_bill_search_example.json')
              .readAsStringSync();
      List<ProPublicaBill> bills =
          ProPublicaBill.fromResponseBodyList(billString);
      expect(bills.length, 10);
      expect(bills[0].billId, '113-hr-2739');
    });

    test('Testing Pro Publica Bill Creation from API response', () async {
      // https://www.govtrack.us/congress/bills/118/hr5204
      ProPublicaApi proPublicaApi = ProPublicaApi(client: client);
      Bill bill = ProPublicaBill.fromExample();
      Response response = await proPublicaApi.getBillDetails(bill: bill);
      Bill billDetails =
          Bill.fromResponseBody(response.body, BillSource.proPublica);
      expect(billDetails.billId, '116-hr-502');
    });
  });
  group('Testing GovinfoBill', () {
    test('Testing govinfobill creation from example', () {
      Bill bill = GovinfoBill.fromExample();
      expect(bill.billId, '115-hr-1625enr');
      expect(bill.title.contains('State Department Basic Authorities'), true);
    });
    test('Testing govinfobill list creation from example', () {
      List<Bill> bills = GovinfoBill.fromExampleKeywordSearch();
      expect(bills.length, 10);
      expect(bills.first.billId, '115-sres-160is');
      expect(bills.first.title.contains('Honoring the service'), true);
      expect(bills.last.billId, '114-hres-752ih');
      expect(bills.last.title.contains('Yulin, China'), true);
    });
    test('Testing govinfobill creation from API response', () async {
      GovinfoApi govinfoApi = GovinfoApi(client: client);
      Response response =
          await govinfoApi.getBillDetails(billId: 'BILLS-115hr1625enr');
      expect(response.statusCode, 200);
      Bill bill = GovinfoBill.fromResponseBody(response.body);
      expect(bill.billId, '115-hr-1625enr');
      expect(bill.title.contains('State Department Basic Authorities'), true);
    });
    test('Testing govinfobill list creation from API response', () async {
      GovinfoApi govinfoApi = GovinfoApi(client: client);
      Response response =
          await govinfoApi.searchBillsByKeyword(keyword: 'climate');
      expect(response.statusCode, 200);
      List<Bill> bills = GovinfoBill.fromResponseBodyList(response.body);
      expect(bills.length, 20);
    });
  });
}
