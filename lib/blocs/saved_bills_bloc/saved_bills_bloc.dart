import 'package:bloc/bloc.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'saved_bills_event.dart';
part 'saved_bills_state.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import

class SavedBillsBloc extends HydratedBloc<SavedBillsEvent, SavedBillsState> {
  SavedBillsBloc() : super(const SavedBillsState()) {
    on<ReplaceBills>(
      (event, emit) => emit(state.copyWith(
        bills: event.bills,
        status: SavedBillsStatus.success,
      )),
    );
    on<SaveBill>((event, emit) => emit(state.copyWith(
          status: SavedBillsStatus.success,
          bills: [...state.bills, event.bill],
        )));
    on<RemoveBill>(
      (event, emit) {
        List<Bill> newBills = [
          for (final bill in state.bills)
            if (bill.billId != event.bill.billId) bill,
        ];
        emit(state.copyWith(
            bills: newBills,
            status: newBills.isEmpty
                ? SavedBillsStatus.initial
                : SavedBillsStatus.success));
      },
    );
  }

  @override
  SavedBillsState? fromJson(Map<String, dynamic> json) {
    return SavedBillsState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(SavedBillsState state) {
    return state.toMap();
  }
}
