// abstract class for bills provider with methods for:
// - getting bill details by ID
// - getting a list of bills by search query including: published date range, collection codes, document classes, and size
// - printing a log of the response from the API

import 'package:democratus/enums/bill_type.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/congress_gov_bill.dart';
import 'package:http/http.dart';

//TODO: define this class to act as a consistent interface for all bills providers
abstract class BillsProvider {
  Future<Response> getBillById(int congress, BillType type, int number);
}
