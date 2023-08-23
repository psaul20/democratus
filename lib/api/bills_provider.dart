// abstract class for bills provider with methods for:
// - getting bill details by ID
// - getting a list of bills by search query including: published date range, collection codes, document classes, and size
// - printing a log of the response from the API

import 'package:democratus/models/bill_models/congress_gov_bill.dart';
import 'package:http/http.dart';

abstract class BillsProvider {
  Future<CongressGovBill> getBillById(
      String billType, int billNumber, int congress);
  Future<CongressGovBill> searchBills({
    required DateTime startDate,
    DateTime? endDate,
    required List collectionCodes,
    int size = 10,
    List<String> docClasses = const <String>[],
  });
  void logUsage(Response response);
}
