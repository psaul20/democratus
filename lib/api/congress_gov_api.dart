import 'package:democratus/models/congress_gov_bill/bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import 'api_usage.dart';

class CongressGovAPI {
  static String apiKey = dotenv.env['CONGRESS_GOV_API_KEY'] ?? '';
  static String baseUrl = 'https://api.congress.gov';
  // Create api call method based on example url: https://api.congress.gov/v3/bill/117/hr/3076?api_key=[INSERT_KEY]
  static Future<Response> getBillData(
      int congress, String billType, int billNumber) async {
    String url =
        '$baseUrl/v3/bill/${congress.toString()}/$billType/${billNumber.toString()}?api_key=$apiKey';
    Response response = await get(Uri.parse(url));
    ApiUsage.logUsage(response);
    return response;
  }
}
