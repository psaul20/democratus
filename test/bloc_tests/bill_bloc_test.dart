import 'dart:io';

import 'package:democratus/blocs/bloc/bill_bloc.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart' as http;
import 'bill_bloc_test.mocks.dart' as mock;

@GenerateMocks([http.Client])
void main() {
  setUpAll(() => dotenv.testLoad(fileInput: File('.env').readAsStringSync()));

  group('Bill Bloc Tests', () {
    late BillBloc billBloc;
    setUp(() {
      billBloc = BillBloc(ProPublicaBill.fromExample());
    });
    test('Initial state is correct', () {
      expect(billBloc.state, BillState(bill: ProPublicaBill.fromExample()));
    });
    blocTest<BillBloc, BillState>(
      'emits [BillState(bill: bill.copyWith(isSaved: !bill.isSaved))]'
      'when ToggleSave is added',
      build: () => billBloc,
      act: (bloc) => bloc.add(ToggleSave()),
      expect: () => <BillState>[
        BillState(
            bill: ProPublicaBill.fromExample().copyWith(isSaved: true),
            status: BillStatus.success),
      ],
    );
    blocTest<BillBloc, BillState>(
        'emits [BillState(bill: bill.copyWith(hasDetails: true),'
        'status: BillStatus.success)] when GetBillDetails is added',
        build: () => billBloc,
        act: (bloc) => bloc.add(GetBillDetails()),
        wait: const Duration(seconds: 1),
        expect: () => <BillState>[
              BillState(
                  bill: ProPublicaBill.fromExample(),
                  status: BillStatus.loading),
              BillState(
                  bill: ProPublicaBill.fromExample().copyWith(hasDetails: true),
                  status: BillStatus.success),
            ]);
    blocTest<BillBloc, BillState>(
        'emits [BillState(bill: event.bill,'
        'status: BillStatus.success)] when UpdateBill is added',
        build: () => billBloc,
        act: (bloc) => bloc.add(UpdateBill(ProPublicaBill.fromExample())),
        expect: () => <BillState>[
              BillState(
                  bill: ProPublicaBill.fromExample(),
                  status: BillStatus.success),
            ]);
    //TODO: Figure out how to test for failure case
    // blocTest<BillBloc, BillState>(
    //     'emits [BillState(status: BillStatus.failure,'
    //     'except: e as Exception)] when GetBillDetails is added',
    //     build: () => billBloc,
    //     act: (bloc) => bloc.add(GetBillDetails()),
    //     wait: const Duration(seconds: 1),
    //     setUp: () => when(client.get(any)).thenAnswer(
    //         (_) async => throw Exception('Failed to retrieve bill')),
    //     expect: () => <BillState>[
    //           BillState(
    //               bill: ProPublicaBill.fromExample(),
    //               status: BillStatus.loading),
    //           BillState(
    //               bill: ProPublicaBill.fromExample(),
    //               status: BillStatus.failure,
    //               except: Exception('Failed to retrieve bill')),
    //         ]);
  });
}
