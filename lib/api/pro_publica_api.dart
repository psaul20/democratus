// ignore_for_file: unused_import

import 'package:democratus/api/bills_provider.dart';
import 'package:democratus/enums/bill_type.dart';
import 'package:democratus/models/bill_models/congress_gov_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_usage.dart';

class ProPublicaApi {
  static String apiKey = dotenv.env['PRO_PUBLICA_API_KEY'] ?? '';
  static String baseUrl = 'https://api.propublica.org/congress/v1';
  static Map<String, String> headers = {
    'X-API-Key': apiKey,
  };

  // Get bills by subject https://api.propublica.org/congress/v1/bills/subjects/{subject}.json
  static Future<http.Response> getBillsBySubject(
      String subject, http.Client client) async {
    String url = '$baseUrl/bills/subjects/${subject.toLowerCase()}.json';
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    ApiUsage.logUsage(response);
    return response;
  }

  // Get subject by search term https://api.propublica.org/congress/v1/bills/subjects/search.json?query={query}
  static Future<http.Response> getSubjectSearch(
      String query, http.Client client) async {
    String url =
        '$baseUrl/bills/subjects/search.json?query=${query.toLowerCase()}';
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    ApiUsage.logUsage(response);
    return response;
  }

  static Future<http.Response> getBillById(
      int congress, BillType type, int number, http.Client client) async {
    String url =
        '$baseUrl/${congress.toString()}/bills/${type.typeCode}${number.toString()}.json';
    return client.get(Uri.parse(url), headers: headers);
  }
}
