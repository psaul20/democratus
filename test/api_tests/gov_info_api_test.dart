import 'dart:convert';
import 'dart:io';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/globals/strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() async {
  late GovinfoApi govinfoApi;
  setUp(() {
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    Client client = Client();
    govinfoApi = GovinfoApi(client: client);
  });

  group('Testing Govinfo API', () {
    test('Testing Get Bill Details', () async {
      //Using https://github.com/usgpo/api/blob/main/samples/packages/BILLS-115hr1625enr-summary-formatted.json
      Response response =
          await govinfoApi.getBillDetails(billId: 'BILLS-115hr1625enr');
      expect(response.statusCode, 200);
      expect(response.body.contains('1625'), true);
    });
    test('Testing search bills by keyword', () async {
      //Using democratus/lib/assets/text_files/bill_files/govinfo_bill_search_example.json
      String billString =
          File('${Strings.billFilePath}/govinfo_bill_search_example.json')
              .readAsStringSync();
      Map<String, dynamic> json1 = jsonDecode(billString);
      Response response = await govinfoApi.searchBillsByKeyword(
          keyword: 'dog', resetOffset: true);
      Map<String, dynamic> json2 = jsonDecode(response.body);
      expect(json1.keys, json2.keys);
      expect(List.from(json1['results'])[0].keys,
          List.from(json2['results'])[0].keys);
    });
    //Test offset
    test('Testing search bills by keyword with offset', () async {
      Response response1 =
          await govinfoApi.searchBillsByKeyword(keyword: 'megahertz');
      expect(response1.statusCode, 200);
      Map<String, dynamic> jsonResponse1 = jsonDecode(response1.body);
      Response response2 = await govinfoApi.searchBillsByKeyword(
          keyword: 'megahertz', resetOffset: false);

      expect(response2.statusCode, 200);
      Map<String, dynamic> jsonResponse2 = jsonDecode(response2.body);

            expect(jsonResponse1.keys, jsonResponse2.keys);

      List<String> billIds1 = List<String>.from(jsonResponse1['results']
          .map((bill) => bill['packageId'].toString())
          .toList());

      List<String> billIds2 = List<String>.from(jsonResponse2['results']
          .map((bill) => bill['packageId'].toString())
          .toList());

      for (String billId in billIds2) {
        expect(billIds1.contains(billId), false);
      }

      Map<String, dynamic> jsonExample = jsonDecode(
          File('${Strings.billFilePath}/govinfo_bill_search_example.json')
              .readAsStringSync());

      expect(jsonExample.keys, jsonResponse2.keys);
    });
  });
}
