import 'package:democratus/globals/enums/bloc_states/saved_bills_status.dart';
import 'package:democratus/models/bill_models/bill.dart';
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
    on<ToggleSave>((event, emit) {
      List<String> billIds = [
        for (final bill in state.bills) bill.billId,
      ];
      if (billIds.contains(event.bill.billId)) {
        List<Bill> newBills = [
          for (final bill in state.bills)
            if (bill.billId != event.bill.billId) bill,
        ];
        emit(state.copyWith(
            bills: newBills,
            status: newBills.isEmpty
                ? SavedBillsStatus.initial
                : SavedBillsStatus.success));
      } else {
        emit(state.copyWith(
          status: SavedBillsStatus.success,
          bills: [...state.bills, event.bill],
        ));
      }
    });
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
