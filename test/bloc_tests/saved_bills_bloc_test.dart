// ignore_for_file: unused_import

import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/govinfo_bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:democratus/globals/enums/bloc_states/saved_bills_status.dart';

import '../mocks.dart';

void main() {
  group('Saved Bills Bloc Tests', () {
    List<Bill> bills = GovinfoBill.fromExampleKeywordSearch();
    setUpAll(() async {
      initHydratedStorage();
    });
    blocTest(
      'emits [SavedBillsState(bills: bills)] when replaceBills is added',
      build: () => SavedBillsBloc(),
      act: (bloc) => bloc.add(ReplaceBills(bills: bills)),
      expect: () => <SavedBillsState>[
        SavedBillsState(bills: bills, status: SavedBillsStatus.success),
      ],
    );
    //test ToggleSave event
    blocTest(
      'emits [SavedBillsState(bills: bills)] when ToggleSave is added',
      build: () => SavedBillsBloc(),
      act: (bloc) => bloc.add(ToggleSave(bill: bills[0])),
      expect: () => <SavedBillsState>[
        SavedBillsState(bills: [bills[0]], status: SavedBillsStatus.success),
      ],
    );
  });
}
