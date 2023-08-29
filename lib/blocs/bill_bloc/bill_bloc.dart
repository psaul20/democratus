// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'bill_event.dart';
part 'bill_state.dart';

enum BillStatus { success, loading, failure }

class BillBloc extends Bloc<BillEvent, BillState> {
  http.Client client;
  BillBloc({required bill, client})
      : client = client ?? http.Client(),
        super(BillState(bill: bill)) {
    on<UpdateBill>((event, emit) => emit(state.copyWith(
          bill: event.bill,
          status: BillStatus.success,
        )));
    on<ToggleSave>(
      (event, emit) => emit(state.copyWith(
          bill: state.bill.copyWith(isSaved: !state.bill.isSaved))),
    );
    on<GetBillDetails>(_onGetBill);
  }

  Future<void> _onGetBill(GetBillDetails event, Emitter<BillState> emit) async {
    try {
      if (!state.bill.hasDetails) {
        emit(state.copyWith(status: BillStatus.loading));
        final Bill bill = await _fetchBill();
        emit(state.copyWith(
          bill: bill.copyWith(hasDetails: true),
          status: BillStatus.success,
        ));
      }
    } catch (e) {
      log("Exception: $e");
      emit(state.copyWith(status: BillStatus.failure, except: e as Exception));
    }
  }

  Future<Bill> _fetchBill() async {
    http.Response response = await ProPublicaApi.getBillById(
        state.bill.congress, state.bill.type, state.bill.number, client);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Bill bill = ProPublicaBill.fromResponseBody(response.body);
      return bill;
    } else if (response.statusCode == 429) {
      throw Exception("429: Too many requests");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to retrieve bill');
    }
  }
}
