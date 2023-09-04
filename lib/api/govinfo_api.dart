import 'dart:convert';

import 'package:democratus/api/api_usage.dart';
import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/globals/enums/bill_provider_params.dart';
import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class GovinfoApi implements BillApiProvider {
  // final String apiKey = 'DEMO_KEY';
  final String apiKey = dotenv.env['GOVINFO_API_KEY']!;

  GovinfoApi({required this.client});

  Future<Response> getCollections() async {
    final String url = "https://api.govinfo.gov/collections?api_key=$apiKey";
    final response = await http.get(Uri.parse(url));
    ApiUsage.logUsage(response);
    return response;
  }

  Future<Response> searchPackages({
    required DateTime startDate,
    DateTime? endDate,
    required List collectionCodes,
    int size = 10,
    List<String> docClasses = const <String>[],
  }) async {
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

  // Future<String> getHtml(Package package) async {
  //   String? url = package.download?['txtLink'];
  //   if (url != null) {
  //     url = '$url?api_key=$apiKey';
  //     final response = await http.get(Uri.parse(url));
  //     ApiUsage.logUsage(response);
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       // If the server did not return a 200 OK response,
  //       // then throw an exception.
  //       throw Exception('Failed to retrieve package text');
  //     }
  //   } else {
  //     return Future.error(Exception("Html Link not found"));
  //   }
  // }

  @override
  http.Client client;

  @override
  BillSource source = BillSource.govinfo;

  @override
  Future<http.Response> getBillDetails({Bill? bill, String? billId}) async {
    assert(bill != null || billId != null);
    String packageId = billId ?? bill!.govInfoId!;
    final String url =
        "https://api.govinfo.gov/packages/$packageId/summary?api_key=$apiKey";
    final http.Response response = await http.get(Uri.parse(url));
    logUsage(response);
    return response;
  }

  // See postman for examples: https://web.postman.co/workspace/486fcfdc-96d7-44af-8358-e483423cfc49/request/29492470-1de52e7c-b0b9-4b57-8d84-b4fc5cdc7817

  @override
  Future<http.Response> searchBillsByKeyword(
      {required String keyword,
      SearchSort sort = SearchSort.relevance,
      bool resetOffset = false}) async {
    final Uri url = Uri.parse('https://api.govinfo.gov/search?api_key=$apiKey');
    final String query = 'collection:(BILLS) $keyword';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final List<Map<String, String>> sorts = [
      {
        'field': sort.sortCode(source),
        'sortOrder': 'DESC',
      }
    ];
    final Map<String, dynamic> body = {
      'query': query,
      'pageSize': '20',
      'offsetMark': nextOffset,
      "resultLevel": "default",
      'sorts': sorts,
    };

    final http.Response response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    logUsage(response);
    updateNextOffset(jsonDecode(response.body)['offsetMark'], resetOffset);

    return response;
  }

  @override
  void logUsage(http.Response response) {
    ApiUsage.logUsage(response);
  }

  @override
  String nextOffset = '*';

  @override
  void updateNextOffset(String nextOffset, bool resetOffset) {
    resetOffset ? this.nextOffset = '*' : this.nextOffset = nextOffset;
  }
}
