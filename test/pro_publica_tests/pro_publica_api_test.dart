import 'dart:convert';
import 'dart:io';

import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  setUpAll(() => dotenv.testLoad(fileInput: File('.env').readAsStringSync()));
  http.Client client = http.Client();
  group('Testing Pro Publica API', () {
    test('Testing well-formed HTTPS request to Pro Publica', () async {
      http.Response response = await ProPublicaApi.getBillsBySubject('Meat', client);
      expect(response.statusCode, 200);
    });
    test('Testing search for bills by subject', () async {
      http.Response response = await ProPublicaApi.getBillsBySubject('Meat', client);
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('test/pro_publica_tests/ref/bills_by_subject_example.json')
              .readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonResponse['subject'], jsonExample['subject']);
      expect(jsonResponse.keys, jsonExample.keys);
    });
    test('Testing subject search', () async {
      http.Response response = await ProPublicaApi.getSubjectSearch('climate', client);
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('test/pro_publica_tests/ref/subject_search_example.json')
              .readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonExample.keys, jsonResponse.keys);
    });
    test('Testing Bill retrieval by ID', () async {
      http.Response response =
          await ProPublicaApi.getBillById(116, 'hr'.billTypeFromCode, 502, client);
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('test/pro_publica_tests/ref/bill_example.json')
              .readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonExample.keys, jsonResponse.keys);
    });
    test('Testing Bill retrieval by keyword', () async {
      http.Response response =
          await ProPublicaApi.getBillByKeyword(keyword: 'megahertz', client: client);
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('test/pro_publica_tests/ref/bill_search_example.json')
              .readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonExample.keys, jsonResponse.keys);
    });
  });
}
