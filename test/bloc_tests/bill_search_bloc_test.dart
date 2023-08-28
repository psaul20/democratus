import 'dart:io';
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
  String exampleJson = File('${Strings.billFilePath}/bill_search_example.json')
      .readAsStringSync();
  group('Bill_Search_Bloc tests', () {
    setUp(() {
      initHydratedStorage();
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
      client = MockClient();
    });
    blocTest(
      'emits [BillSearchState(status: BillSearchStatus.searching),'
      'BillSearchState(status: BillSearchStatus.success, searchBills: [Bills])]'
      'when KeywordSearch is added',
      build: () {
        when(client.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(exampleJson, 200));
        return BillSearchBloc(client: client);
      },
      act: (bloc) => bloc.add(KeywordSearch(keyword: 'climate')),
      expect: () => <BillSearchState>[
        const BillSearchState(
            status: BillSearchStatus.searching, keyword: 'climate'),
        BillSearchState(
            status: BillSearchStatus.success,
            keyword: 'climate',
            searchBills:
                List<Bill>.from(ProPublicaBill.fromExampleKeywordSearch())),
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
        return BillSearchBloc(client: client);
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
  });
  //bloctest for keyword empty
  blocTest(
    'emits [BillSearchState(status: BillSearchStatus.initial,'
    'searchBills: [])]'
    'when KeywordSearch is added',
    build: () {
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('', 200));
      return BillSearchBloc(client: client);
    },
    act: (bloc) => bloc.add(KeywordSearch(keyword: '')),
    expect: () => <BillSearchState>[
      const BillSearchState(
          status: BillSearchStatus.initial, keyword: ''),
    ],
    verify: (bloc) => bloc.state.searchBills.isEmpty,
  );
}
