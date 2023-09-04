import 'dart:convert';
import 'dart:io';
import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_search_status.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/govinfo_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../mocks.dart';

void main() {
  late BillApiProvider billsApiProvider;
  List<Bill> testBills = GovinfoBill.fromExampleKeywordSearch();
  Bill testBill = GovinfoBill.fromExample();
  List<Bill> offsetBills = [];
  offsetBills.addAll(testBills + testBills);
  offsetBills.add(testBill);
  String searchBillJson =
      File('${Strings.billFilePath}/govinfo_bill_search_example.json')
          .readAsStringSync();
  String billDetailsJson =
      File('${Strings.billFilePath}/govinfo_bill_example.json')
          .readAsStringSync();
  Map<String, String> headers = {
    'content-type': 'application/json; charset=utf-8'
  };
  Response searchResponse = Response(searchBillJson, 200, headers: headers);
  setUp(() {
    initHydratedStorage();
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    billsApiProvider = MockBillApiProvider();
    when(() => billsApiProvider.searchBillsByKeyword(
            keyword: any(named: 'keyword'),
            resetOffset: any(named: 'resetOffset')))
        .thenAnswer((invocation) async => searchResponse);
  });
  group('Bill_Search_Bloc Keyword tests', () {
    blocTest(
      'emits [BillSearchState(status: BillSearchStatus.searching),'
      'BillSearchState(status: BillSearchStatus.success, searchBills: [Bills])]'
      'when KeywordSearch is added',
      build: () {
        return BillSearchBloc(billApiProvider: billsApiProvider);
      },
      act: (bloc) => bloc.add(KeywordSearch(keyword: 'climate')),
      expect: () => <BillSearchState>[
        const BillSearchState(
            status: BillSearchStatus.searching, keyword: 'climate'),
        BillSearchState(
            status: BillSearchStatus.success,
            keyword: 'climate',
            searchBills: testBills),
      ],
      verify: (bloc) => bloc.state.searchBills.isNotEmpty,
    );
    //bloctest for failure case
    blocTest(
      'emits [BillSearchState(status: BillSearchStatus.searching),'
      'BillSearchState(status: BillSearchStatus.failure, searchBills: [])]'
      'when KeywordSearch is added',
      build: () {
        when(() => billsApiProvider.searchBillsByKeyword(
                keyword: any(named: 'keyword'),
                resetOffset: any(named: 'resetOffset')))
            .thenAnswer((invocation) async => Response('', 400));
        return BillSearchBloc(billApiProvider: billsApiProvider);
      },
      act: (bloc) => bloc.add(KeywordSearch(keyword: 'climate')),
      expect: () => <BillSearchState>[
        const BillSearchState(
            status: BillSearchStatus.searching, keyword: 'climate'),
        const BillSearchState(
            status: BillSearchStatus.failure, keyword: 'climate'),
      ],
      verify: (bloc) => bloc.state.searchBills.isEmpty,
    );
    //bloctest for keyword empty
    blocTest(
      'emits [BillSearchState(status: BillSearchStatus.initial,'
      'searchBills: [])]'
      'when KeywordSearch is added',
      build: () {
        return BillSearchBloc(
            billApiProvider: billsApiProvider,
            initState: const BillSearchState(keyword: 'climate'));
      },
      act: (bloc) => bloc.add(KeywordSearch(keyword: '')),
      expect: () => <BillSearchState>[
        const BillSearchState(status: BillSearchStatus.initial, keyword: ''),
      ],
      verify: (bloc) => bloc.state.searchBills.isEmpty,
    );
    //bloctest for same keyword added twice
    blocTest(
      'emits [BillSearchState(status: BillSearchStatus.searching),'
      'BillSearchState(status: BillSearchStatus.success, searchBills: [Bills])]'
      'when KeywordSearch is added',
      build: () {
        return BillSearchBloc(
            billApiProvider: billsApiProvider,
            initState: BillSearchState(
                status: BillSearchStatus.success,
                searchBills: testBills,
                keyword: 'climate'));
      },
      act: (bloc) => bloc.add(KeywordSearch(keyword: 'climate')),
      expect: () => <BillSearchState>[],
    );
  });
  group('BillSearch Bloc ScrollOffset Tests', () {
    blocTest(
      'ScrollSearchOffset adds more bills to searchBills',
      build: () {
        return BillSearchBloc(billApiProvider: billsApiProvider);
      },
      act: (bloc) => bloc.add(ScrollSearchOffset()),
      expect: () => <BillSearchState>[
        const BillSearchState(status: BillSearchStatus.searching),
        BillSearchState(
            status: BillSearchStatus.success,
            searchBills: testBills,
            hasReachedMax: true),
      ],
    );
    blocTest(
      'Search does not add more bills if hasReachedMax is true',
      build: () {
        return BillSearchBloc(
            billApiProvider: billsApiProvider,
            initState: BillSearchState(
              status: BillSearchStatus.success,
              searchBills: testBills + testBills,
            ));
      },
      act: (bloc) {
        bloc.add(ScrollSearchOffset());
      },
      expect: () => [isA<BillSearchState>(), isA<BillSearchState>()],
      verify: (bloc) =>
          bloc.state.searchBills.length == 21 &&
          bloc.state.hasReachedMax &&
          bloc.state.status == BillSearchStatus.success,
    );
  });
}
