import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/globals/enums/bloc_states/bill_search_status.dart';
import 'package:democratus/models/bill_models/bill.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'bill_search_event.dart';
part 'bill_search_state.dart';

class BillSearchBloc extends HydratedBloc<BillSearchEvent, BillSearchState> {
  BillApiProvider billApiProvider;
  BillSearchState? initState;
  BillSearchBloc({required this.billApiProvider, this.initState})
      : super(initState ?? const BillSearchState()) {
    on<KeywordSearch>(_onKeywordSearch);
    on<ScrollSearchOffset>(_onScrollSearchOffset);
  }
  _onKeywordSearch(KeywordSearch event, Emitter<BillSearchState> emit) async {
    if (event.keyword == state.keyword && state.searchBills.isNotEmpty) {
      return;
    }

    if (event.keyword.isEmpty) {
      emit(state.copyWith(
          status: BillSearchStatus.initial,
          keyword: event.keyword,
          hasReachedMax: false,
          searchBills: []));
      return;
    }
    try {
      emit(state.copyWith(
          status: BillSearchStatus.searching,
          keyword: event.keyword,
          searchBills: []));
      final List<Bill> bills = await _fetchBillsByKeyword(event.keyword, true);
      emit(state.copyWith(
        searchBills: bills,
        hasReachedMax: false,
        status: BillSearchStatus.success,
      ));
    } catch (e) {
      log("Exception: $e");
      emit(state.copyWith(status: BillSearchStatus.failure));
    }
  }

  Future<List<Bill>> _fetchBillsByKeyword(String keyword, bool resetOffset) async {
    http.Response response =
        await billApiProvider.searchBillsByKeyword(keyword: keyword, resetOffset: resetOffset);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Bill> bills =
          Bill.fromResponseBodyList(response.body, billApiProvider.source);
      return bills;
    } else if (response.statusCode == 429) {
      throw Exception("429: Too many requests");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to retrieve bills');
    }
  }

  _onScrollSearchOffset(
      ScrollSearchOffset event, Emitter<BillSearchState> emit) async {
    if (state.hasReachedMax) {
      log("Reached max");
      return;
    }

    try {
      emit(state.copyWith(
        status: BillSearchStatus.searching,
      ));

      final List<Bill> bills = [];
      final List<Bill> newBills = await _fetchBillsByKeyword(state.keyword, false);
      bills.addAll(state.searchBills);
      bills.addAll(newBills);
      emit(state.copyWith(
        searchBills: bills,
        status: BillSearchStatus.success,
        hasReachedMax: newBills.length < 20,
      ));
    } catch (e) {
      log("Exception: $e");
      emit(state.copyWith(status: BillSearchStatus.failure));
    }
  }

  @override
  BillSearchState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return BillSearchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(BillSearchState state) {
    return state.toMap();
  }
}
