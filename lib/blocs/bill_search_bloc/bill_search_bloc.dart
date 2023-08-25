import 'package:bloc/bloc.dart';
import 'package:democratus/enums/bill_type.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:meta/meta.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'bill_search_event.dart';
part 'bill_search_state.dart';

class BillSearchBloc extends HydratedBloc<BillSearchEvent, BillSearchState> {
  BillSearchBloc() : super(BillSearchState()) {
    on<KeywordSearch>(_onKeywordSearch);
  }
  _onKeywordSearch(KeywordSearch event, Emitter<BillSearchState> emit) async {
    try {
      emit(state.copyWith(status: BillSearchStatus.searching));
      final List<Bill> bills = await _fetchBills(event.keyword);
      emit(state.copyWith(
        bills: bills,
        status: BillSearchStatus.success,
      ));
    } catch (e) {
      log("Exception: $e");
      emit(state.copyWith(
          status: BillSearchStatus.failure, except: e as Exception));
    }
  }

  Future<List<Bill>> _fetchBills(String keyword) async {
    Client client = Client();
    Response response = await GovInfoApi.searchBills(keyword, client);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Package package = Package.fromJson(jsonDecode(response.body));
      List<Bill> bills = package.bills;
      return bills;
    } else if (response.statusCode == 429) {
      throw Exception("429: Too many requests");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to retrieve bills');
    }
  }
}
