import 'dart:convert';
import 'dart:io';

import 'package:democratus/api/pro_publica_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  setUpAll(() => dotenv.testLoad(fileInput: File('.env').readAsStringSync()));
  group('Testing Pro Publica API', () {
    test('Testing well-formed HTTPS request to Pro Publica', () async {
      Response response = await ProPublicaApi.getBillsBySubject('Meat');
      expect(response.statusCode, 200);
    });
    test('Testing search for bills by subject', () async {
      Response response = await ProPublicaApi.getBillsBySubject('Meat');
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
      Response response = await ProPublicaApi.getSubjectSearch('climate');
      expect(response.statusCode, 200);
      Map<String, dynamic> jsonExample = jsonDecode(
          File('test/pro_publica_tests/ref/subject_search_example.json')
              .readAsStringSync());
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      expect(jsonResponse['status'], 'OK');
      expect(jsonExample.keys, jsonResponse.keys);
    });
  });
}
