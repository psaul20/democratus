// ignore_for_file: unused_import

import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:democratus/globals/enums/bill_provider_params.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/congress_gov_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'api_usage.dart';

//TODO: In the future, ideally this is a repository pattern

class ProPublicaApi implements BillApiProvider {
  String apiKey = dotenv.env['PRO_PUBLICA_API_KEY'] ?? '';
  String baseUrl = 'https://api.propublica.org/congress/v1';
  Map<String, String> get headers => {
        'X-API-Key': apiKey,
      };

  ProPublicaApi({required this.client});

  // Get bills by subject https://api.propublica.org/congress/v1/bills/subjects/{subject}.json
  Future<http.Response> getBillsBySubject(String subject) async {
    String url = '$baseUrl/bills/subjects/${subject.toLowerCase()}.json';
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    ApiUsage.logUsage(response);
    return response;
  }

  // Get subject by search term https://api.propublica.org/congress/v1/bills/subjects/search.json?query={query}
  Future<http.Response> getSubjectSearch(String query) async {
    String url =
        '$baseUrl/bills/subjects/search.json?query=${query.toLowerCase()}';
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    logUsage(response);
    return response;
  }

  @override
  Future<http.Response> getBillDetails({Bill? bill, String? billId}) async {
    assert(bill != null);
    assert(bill?.congress != null);
    String url =
        '$baseUrl/${bill!.congress.toString()}/bills/${bill.type.typeCode}${bill.number.toString()}.json';
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    logUsage(response);
    return response;
  }

// Get bill by keyword https://api.propublica.org/congress/v1/bills/search.json?query={query}
  @override
  Future<http.Response> searchBillsByKeyword(
      {required String keyword,
      SearchSort sort = SearchSort.relevance,
      bool resetOffset = false}) async {
    String url =
        '$baseUrl/bills/search.json?query=${keyword.toLowerCase()}&sort=${sort.sortCode}&offset=$nextOffset';
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    logUsage(response);
    updateNextOffset('20', resetOffset);
    return response;
  }

  @override
  void logUsage(http.Response response) {
    ApiUsage.logUsage(response);
  }

  @override
  http.Client client;

  @override
  BillSource source = BillSource.proPublica;

  @override
  String nextOffset = '0';

  @override
  void updateNextOffset(String nextOffset, bool resetOffset) {
    resetOffset ? this.nextOffset = '0' : this.nextOffset = nextOffset;
  }
}
