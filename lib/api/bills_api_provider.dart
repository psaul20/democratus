// abstract class for bills provider with methods for:
// - getting bill details by ID
// - getting a list of bills by search query including: published date range, collection codes, document classes, and size
// - printing a log of the response from the API

import 'package:democratus/globals/enums/bill_provider_params.dart';
import 'package:democratus/globals/enums/bill_source.dart';
import 'package:democratus/globals/enums/bill_type.dart';
import 'package:http/http.dart';

//TODO: define this class to act as a consistent interface for all bills providers
abstract class BillApiProvider {
  Client client;
  BillSource source;
  BillApiProvider({required this.client, required this.source});
  void logUsage(Response response);
  Future<Response> getBillById(int congress, BillType type, int number);
  Future<Response> getBillsByKeyword(
      {required String keyword, SearchSort sort, int offset});
}