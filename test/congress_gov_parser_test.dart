//create uri from the example url

import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:democratus/api/congress_gov_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() async {
  // Uri testUri = CongressGovApi.getSearchUri(getCsv: false, congresses: [
  //   118
  // ], policyAreas: [
  //   'Health',
  //   'Armed Forces and National Security',
  // ]);
  Uri testUri = CongressGovApi.getSearchUri();
  log(testUri.toString());

  //write a method which takes in the parameters of the example URL, submits an http request, and returns the response
  Response response = await http.get(testUri);
  test('Testing well-formed HTTPS request to Congress.gov', () {
    expect(response.statusCode, 200);
    expect(response.body.isNotEmpty, true);
  });

  List<List<dynamic>> csvData =
      const CsvToListConverter().convert(response.body);

  // write csv data to file
  File('test.csv').writeAsString(response.body);
  log(csvData.first.toString());
}
