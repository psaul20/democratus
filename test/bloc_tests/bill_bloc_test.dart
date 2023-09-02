import 'dart:io';
import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart' as http;
import 'package:democratus/globals/enums/bloc_states/bill_status.dart';

import 'bill_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late BillBloc billBloc;
  setUpAll(
    () {
      client = MockClient();
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(
              File('${Strings.billFilePath}/bill_example.json')
                  .readAsStringSync(),
              200));
      billBloc = BillBloc(bill: ProPublicaBill.fromExample(), client: client);
    },
  );

  group('Bill Bloc Tests', () {
    test('Initial state is correct', () {
      expect(billBloc.state, BillState(bill: ProPublicaBill.fromExample()));
    });
    blocTest<BillBloc, BillState>(
        'emits [BillState(bill: bill.copyWith(hasDetails: true),'
        'status: BillStatus.success)] when GetBillDetails is added',
        build: () =>
            BillBloc(bill: ProPublicaBill.fromExample(), client: client),
        act: (bloc) => bloc.add(GetBillDetails()),
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
        build: () =>
            BillBloc(bill: ProPublicaBill.fromExample(), client: client),
        act: (bloc) => bloc.add(UpdateBill(ProPublicaBill.fromExample())),
        expect: () => <BillState>[
              BillState(
                  bill: ProPublicaBill.fromExample(),
                  status: BillStatus.success),
            ]);
    blocTest<BillBloc, BillState>(
      'emits [BillState(status: BillStatus.failure,'
      'except: e as Exception)] when GetBillDetails is added',
      build: () {
        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('error', 404));
        return BillBloc(bill: ProPublicaBill.fromExample(), client: client);
      },
      act: (bloc) => bloc.add(GetBillDetails()),
      verify: (bloc) =>
          bloc.state.status == BillStatus.failure &&
          bloc.state.except is Exception,
    );
  });
}
