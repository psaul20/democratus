import 'dart:io';
import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/govinfo_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:democratus/globals/enums/bloc_states/bill_status.dart';

import '../mocks.dart';

void main() {
  late BillBloc billBloc;
  late BillApiProvider billsApiProvider;
  late Bill testBill;
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(
    () {

      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
      billsApiProvider = MockBillApiProvider();
      String billDetailsJson =
          File('${Strings.billFilePath}/govinfo_bill_example.json')
              .readAsStringSync();
      Map<String, String> headers = {
        'content-type': 'application/json; charset=utf-8'
      };
      Response searchResponse =
          Response(billDetailsJson, 200, headers: headers);
      when(() => billsApiProvider.getBillDetails(
              bill: any(named: 'bill'), billId: any(named: 'billId')))
          .thenAnswer((invocation) async => searchResponse);
      testBill = GovinfoBill.fromExample();
      billBloc = BillBloc(
          bill: testBill, billApiProvider: billsApiProvider);
    },
  );

  group('Bill Bloc Tests', () {
    test('Initial state is correct', () {
      expect(billBloc.state, BillState(bill: testBill));
    });
    blocTest<BillBloc, BillState>(
        'emits [BillState(bill: bill.copyWith(hasDetails: true),'
        'status: BillStatus.success)] when GetBillDetails is added',
        build: () => BillBloc(
          bill: testBill, billApiProvider: billsApiProvider),
        act: (bloc) => bloc.add(GetBillDetails()),
        expect: () => <BillState>[
              BillState(
                  bill: testBill,
                  status: BillStatus.loading),
              BillState(
                  bill: testBill.copyWith(hasDetails: true),
                  status: BillStatus.success),
            ]);
    blocTest<BillBloc, BillState>(
        'emits [BillState(bill: event.bill,'
        'status: BillStatus.success)] when UpdateBill is added',
        build: () => BillBloc(
          bill: testBill, billApiProvider: billsApiProvider),
        act: (bloc) => bloc.add(UpdateBill(testBill)),
        expect: () => <BillState>[
              BillState(
                  bill: testBill,
                  status: BillStatus.success),
            ]);
    blocTest<BillBloc, BillState>(
      'emits [BillState(status: BillStatus.failure,'
      'except: e as Exception)] when GetBillDetails is added',
      build: () {
        when(() => billsApiProvider.getBillDetails(
                bill: any(named: 'bill'), billId: any(named: 'billId')))
            .thenAnswer((invocation) async => Response('', 404));
        return BillBloc(
            bill: testBill,
            billApiProvider: billsApiProvider);
      },
      act: (bloc) => bloc.add(GetBillDetails()),
      verify: (bloc) =>
          bloc.state.status == BillStatus.failure &&
          bloc.state.except is Exception,
    );
  });
}
