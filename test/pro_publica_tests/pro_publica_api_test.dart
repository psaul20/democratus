import 'dart:convert';
import 'dart:io';

import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:democratus/globals/strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  late ProPublicaApi proPublicaApi;
  setUpAll(() {
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    http.Client client = http.Client();
    proPublicaApi = ProPublicaApi(client: client);
  });

  group('Testing Pro Publica API', () {
    test('Testing well-formed HTTPS request to Pro Publica', () async {
      http.Response response = await proPublicaApi.getBillsBySubject('Meat');
      expect(response.statusCode, 200);
    });
    test('Testing search for bills by subject', () async {
      http.Response response = await proPublicaApi.getBillsBySubject('Meat');
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('${Strings.billFilePath}/bills_by_subject_example.json')
              .readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonResponse['subject'], jsonExample['subject']);
      expect(jsonResponse.keys, jsonExample.keys);
    });
    test('Testing subject search', () async {
      http.Response response = await proPublicaApi.getSubjectSearch('climate');
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('${Strings.billFilePath}/subject_search_example.json')
              .readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonExample.keys, jsonResponse.keys);
    });
    test('Testing Bill retrieval by ID', () async {
      http.Response response =
          await proPublicaApi.getBillById(116, 'hr'.billTypeFromCode, 502);
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('${Strings.billFilePath}/bill_example.json').readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonExample.keys, jsonResponse.keys);
    });
    test('Testing Bill retrieval by keyword', () async {
      http.Response response =
          await proPublicaApi.getBillsByKeyword(keyword: 'megahertz');
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('${Strings.billFilePath}/bill_search_example.json')
              .readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonExample.keys, jsonResponse.keys);
    });
    // test bill retrieval by keyword with offset
    test('Testing Bill retrieval by keyword with offset', () async {
      http.Response response1 =
          await proPublicaApi.getBillsByKeyword(keyword: 'megahertz');
      expect(response1.statusCode, 200);
      Map<String, dynamic> jsonResponse1 = jsonDecode(response1.body);
      expect(jsonResponse1['status'], 'OK');
      http.Response response2 = await proPublicaApi.getBillsByKeyword(
          keyword: 'megahertz', offset: 20);

      expect(response2.statusCode, 200);
      Map<String, dynamic> jsonResponse2 = jsonDecode(response2.body);
      expect(jsonResponse2['status'], 'OK');

      List<String> billIds1 = List<String>.from(jsonResponse1['results'][0]
              ['bills']
          .map((bill) => bill['bill_id'].toString())
          .toList());

      List<String> billIds2 = List<String>.from(jsonResponse2['results'][0]
              ['bills']
          .map((bill) => bill['bill_id'].toString())
          .toList());

      expect(jsonResponse1.keys, jsonResponse2.keys);
      for (String billId in billIds2) {
        expect(billIds1.contains(billId), false);
      }

      Map<String, dynamic> jsonExample = jsonDecode(
          File('${Strings.billFilePath}/bill_search_example.json')
              .readAsStringSync());

      expect(jsonExample.keys, jsonResponse2.keys);
    });
  });
}
