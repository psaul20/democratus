// ignore_for_file: unused_import

import 'package:democratus/models/bill_models/congress_gov_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import 'api_usage.dart';

class ProPublicaApi {
  static String apiKey = dotenv.env['PRO_PUBLICA_API_KEY'] ?? '';
  static String baseUrl = 'https://api.propublica.org/congress/v1/bills';
  static Map<String, String> headers = {
    'X-API-Key': apiKey,
  };

  // Get bills by subject https://api.propublica.org/congress/v1/bills/subjects/{subject}.json
  static Future<Response> getBillsBySubject(String subject) async {
    String url = '$baseUrl/subjects/${subject.toLowerCase()}.json';
    Response response = await get(Uri.parse(url), headers: headers);
    ApiUsage.logUsage(response);
    return response;
  }

  // Get subject by search term https://api.propublica.org/congress/v1/bills/subjects/search.json?query={query}
  static Future<Response> getSubjectSearch(String query) async {
    String url = '$baseUrl/subjects/search.json?query=${query.toLowerCase()}';
    Response response = await get(Uri.parse(url), headers: headers);
    ApiUsage.logUsage(response);
    return response;
  }
}
