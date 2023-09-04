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
  });
}
