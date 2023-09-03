// ignore_for_file: unused_import

import 'package:democratus/api/bills_provider.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:democratus/globals/enums/bill_provider_params.dart';
import 'package:democratus/models/bill_models/congress_gov_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'api_usage.dart';

class ProPublicaApi implements BillApiProvider {
  String apiKey = dotenv.env['PRO_PUBLICA_API_KEY'] ?? '';
  String baseUrl = 'https://api.propublica.org/congress/v1';
  Map<String, String> get headers => {
        'X-API-Key': apiKey,
      };

  @override
  final http.Client client;
  ProPublicaApi(this.client);

  // Get bills by subject https://api.propublica.org/congress/v1/bills/subjects/{subject}.json
  Future<http.Response> getBillsBySubject(String subject) async {
    String url = '$baseUrl/bills/subjects/${subject.toLowerCase()}.json';
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    ApiUsage.logUsage(response);
    return response;
  }

  // Get subject by search term https://api.propublica.org/congress/v1/bills/subjects/search.json?query={query}
  Future<http.Response> getSubjectSearch(
      String query, http.Client client) async {
    String url =
        '$baseUrl/bills/subjects/search.json?query=${query.toLowerCase()}';
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    logUsage(response);
    return response;
  }

  @override
  Future<http.Response> getBillById(
      int congress, BillType type, int number) async {
    String url =
        '$baseUrl/${congress.toString()}/bills/${type.typeCode}${number.toString()}.json';
    return client.get(Uri.parse(url), headers: headers);
  }

// Get bill by keyword https://api.propublica.org/congress/v1/bills/search.json?query={query}
  @override
  Future<http.Response> getBillsByKeyword(
      {required String keyword,
      SearchSort sort = SearchSort.relevance,
      int offset = 0}) async {
    String url =
        '$baseUrl/bills/search.json?query=${keyword.toLowerCase()}&sort=${sort.sortCode}&offset=$offset';
    return client.get(Uri.parse(url), headers: headers);
  }

  @override
  Future<http.Response> addOffset(
      Future<http.Response> Function({int offset}) searchFunction, int offset) {
    return searchFunction(offset: offset);
  }

  @override
  void logUsage(http.Response response) {
    ApiUsage.logUsage(response);
  }
}
