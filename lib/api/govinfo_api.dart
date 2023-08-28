import 'dart:developer';

import 'package:democratus/api/api_usage.dart';
import 'package:democratus/models/package.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class GovinfoApi {
  // final String apiKey = 'DEMO_KEY';
  final String apiKey = dotenv.env['GOVINFO_API_KEY']!;
  Future<Response> getPackageById(String packageId) async {
    final String url =
        "https://api.govinfo.gov/packages/$packageId/summary?api_key=$apiKey";
    log("Running getPackageById for ID $packageId against API key: $apiKey");
    final response = await http.get(Uri.parse(url));
    ApiUsage.logUsage(response);
    return response;
  }

  Future<Response> getCollections() async {
    log("Running getCollections with API Key $apiKey");
    final String url = "https://api.govinfo.gov/collections?api_key=$apiKey";
    final response = await http.get(Uri.parse(url));
    ApiUsage.logUsage(response);
    return response;
  }

  //TODO: Implement error handling, endDate
  Future<Response> searchPackages({
    required DateTime startDate,
    DateTime? endDate,
    required List collectionCodes,
    int size = 10,
    List<String> docClasses = const <String>[],
  }) async {
    log("Running search query against API key: $apiKey");
    String startDateString = DateFormat("y-MM-dd").format(startDate);
    endDate ?? startDate;
    String endDateString = DateFormat("y-MM-dd").format(endDate!);
    String codesString = collectionCodes.join(",");
    String docClassesString = docClasses.join(',');
    final String url =
        "https://api.govinfo.gov/published/$startDateString/$endDateString?offset=0&pageSize=${size.toString()}&collection=$codesString&api_key=$apiKey&docClass=$docClassesString";
    Response response = await http.get(Uri.parse(url));
    ApiUsage.logUsage(response);
    return response;
  }

  Future<String> getHtml(Package package) async {
    String? url = package.download?['txtLink'];
    if (url != null) {
      url = '$url?api_key=$apiKey';
      final response = await http.get(Uri.parse(url));
      ApiUsage.logUsage(response);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to retrieve package text');
      }
    } else {
      return Future.error(Exception("Html Link not found"));
    }
  }
}
