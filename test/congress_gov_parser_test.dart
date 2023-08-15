//create uri from the example url

import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:democratus/api/congress_gov_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  group('Testing Congress.Gov search parsing', () {
    test('Testing well-formed HTTPS request to Congress.gov', () async {
      Uri testUri = CongressGovApi.getSearchUri();

      Response response = await http.get(testUri);
      expect(response.statusCode, 200);
      expect(response.body.isNotEmpty, true);
    });

    // test CongressGovApi.parseCsv method
    test('Testing parsing of CSV response from Congress.gov', () async {
      Uri testUri = CongressGovApi.getSearchUri(getCsv: true, congresses: [
        100
      ], policyAreas: [
        'Health',
        'Armed Forces and National Security',
      ]);

      Response response = await http.get(testUri);
      expect(response.statusCode, 200);
      expect(response.body.isNotEmpty, true);
      List<Map<String, dynamic>> csvData =
          CongressGovApi.parseCsv(response.body);
      expect(csvData[0]['Legislation Number'], 'H.R. 5560');
    });
  });
}
