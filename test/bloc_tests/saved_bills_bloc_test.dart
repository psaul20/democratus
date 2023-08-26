import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../mocks.dart';

void main() {
  group('Saved Bills Bloc Tests', () {
    List<Bill> bills = ProPublicaBill.fromExampleSubjectSearch();
    late SavedBillsBloc savedBillsBloc;
    setUpAll(() async {
      initHydratedStorage();
      savedBillsBloc = SavedBillsBloc();
    });
    blocTest(
      'emits [SavedBillsState(bills: bills)] when replaceBills is added',
      build: () => SavedBillsBloc(),
      act: (bloc) => bloc.add(ReplaceBills(bills: bills)),
      expect: () => <SavedBillsState>[
        SavedBillsState(bills: bills, status: SavedBillsStatus.success),
      ],
    );
    blocTest(
      'emits [SavedBillsState(bills: bills)] when saveBill is added',
      build: () => SavedBillsBloc(),
      act: (bloc) => bloc.add(SaveBill(bill: bills[0])),
      expect: () => <SavedBillsState>[
        SavedBillsState(bills: [bills[0]], status: SavedBillsStatus.success),
      ],
    );
    blocTest(
      'emits [SavedBillsState(bills: bills)] when removeBill is added',
      build: () => SavedBillsBloc(),
      act: (bloc) {
        bloc.add(SaveBill(bill: bills[0]));
        bloc.add(RemoveBill(bill: bills[0]));
      },
      expect: () => <SavedBillsState>[
        SavedBillsState(bills: [bills[0]], status: SavedBillsStatus.success),
        const SavedBillsState(bills: [], status: SavedBillsStatus.initial),
      ],
    );
  });
}
