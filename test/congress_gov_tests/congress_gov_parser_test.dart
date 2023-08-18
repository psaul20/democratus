import 'dart:io';

import 'package:democratus/api/congress_gov_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  group('Testing Congress.Gov search parsing', () {
    test('Testing well-formed HTTPS request to Congress.gov', () async {
      Uri testUri = CongressGovSearch.getSearchUri();

      Response response = await http.get(testUri);
      expect(response.statusCode, 200);
      expect(response.body.isNotEmpty, true);
    });

    // test CongressSearchApi.parseCsv method
    test('Testing parsing of CSV response from Congress.gov', () async {
      Uri testUri = CongressGovSearch.getSearchUri(getCsv: true, congresses: [
        100
      ], policyAreas: [
        'Health',
        'Armed Forces and National Security',
      ]);

      Response response = await http.get(testUri);
      expect(response.statusCode, 200);
      expect(response.body.isNotEmpty, true);
      List<Map<String, dynamic>> csvData =
          CongressGovSearch.parseCsvToMaps(response.body);
      expect(csvData[0]['Legislation Number'], 'H.R. 5560');
    });
    test('Testing consolidation of duplicated fields', () {
      // read in example bills.csv file
      String csv = File('test/example_bills.csv').readAsStringSync();
      List<Map<String, dynamic>> csvData =
          CongressGovSearch.parseCsvToMaps(csv);
      // check that the list of maps only has one key for each key that was duplicated in the csv
      List<String> duplicatedKeys = ['Cosponsor', 'Subject', 'Related Bill'];
      for (String key in duplicatedKeys) {
        for (Map<String, dynamic> row in csvData) {
          expect(row.keys.where((element) => element == key).length, 1);
          expect(row[key].runtimeType, List<String>);
        }
      }
    });
  });
}
