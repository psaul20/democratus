import 'dart:io';
import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_search_status.dart';
import 'package:democratus/globals/strings.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart' as http;

import '../mocks.dart';
import 'bill_search_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late BillApiProvider billsApiProvider;
  String searchBillJson =
      File('${Strings.billFilePath}/pro_publica_bill_search_example.json')
          .readAsStringSync();
  String billJson =
      File('${Strings.billFilePath}/pro_publica_bill_example.json')
          .readAsStringSync();
  List<Bill> testBills = ProPublicaBill.fromExampleKeywordSearch();
  Bill testBill = ProPublicaBill.fromExample();
  List<Bill> offsetBills = [];
  offsetBills.addAll(testBills + testBills);
  offsetBills.add(testBill);
  setUp(() {
    initHydratedStorage();
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    client = MockClient();
    billsApiProvider = ProPublicaApi(client: client);
  });
  group('Bill_Search_Bloc Keyword tests', () {
    blocTest(
      'emits [BillSearchState(status: BillSearchStatus.searching),'
      'BillSearchState(status: BillSearchStatus.success, searchBills: [Bills])]'
      'when KeywordSearch is added',
      build: () {
        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(searchBillJson, 200));
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
        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('error', 404));
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
        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('', 200));
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
        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(searchBillJson, 200));
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
        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(searchBillJson, 200));
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
        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(billJson, 200));

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
