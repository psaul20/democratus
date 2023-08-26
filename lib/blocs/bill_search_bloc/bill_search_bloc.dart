import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'bill_search_event.dart';
part 'bill_search_state.dart';

class BillSearchBloc extends HydratedBloc<BillSearchEvent, BillSearchState> {
  final http.Client client;
  BillSearchBloc({required this.client}) : super(const BillSearchState()) {
    on<KeywordSearch>(_onKeywordSearch);
  }
  _onKeywordSearch(KeywordSearch event, Emitter<BillSearchState> emit) async {
    try {
      emit(state.copyWith(
          status: BillSearchStatus.searching, keyword: event.keyword));
      final List<Bill> bills = await _fetchBillsByKeyword(event.keyword);
      emit(state.copyWith(
        searchBills: bills,
        status: BillSearchStatus.success,
      ));
    } catch (e) {
      log("Exception: $e");
      emit(state.copyWith(status: BillSearchStatus.failure));
    }
  }

  Future<List<Bill>> _fetchBillsByKeyword(String keyword) async {
    http.Response response =
        await ProPublicaApi.getBillByKeyword(keyword: keyword, client: client);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Bill> bills = ProPublicaBill.fromResponseBodyList(response.body);
      return bills;
    } else if (response.statusCode == 429) {
      throw Exception("429: Too many requests");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to retrieve bills');
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
