// ignore_for_file: unused_import

import 'dart:io';
import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_search_status.dart';
import 'package:democratus/models/bill_models/govinfo_bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:democratus/pages/bill_search_page.dart';
import 'package:democratus/widgets/bill_sliver_list.dart';
import 'package:democratus/widgets/bill_tile.dart';
import 'package:democratus/widgets/search_widgets/bill_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import '../bloc_tests/bill_search_bloc_test.mocks.dart';
import '../mocks.dart';

Future<void> main() async {
  late MockBillSearchBloc billSearchBloc;
  late MockSavedBillsBloc savedBillsBloc;

  setUpAll(() {
    initHydratedStorage();
    registerFallbackValue(Uri.parse('google.com'));
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    billSearchBloc = MockBillSearchBloc();
    savedBillsBloc = MockSavedBillsBloc();
    when(() => savedBillsBloc.state).thenReturn(const SavedBillsState());
    Client client = MockHttpClient();
    when(() => client.get(any())).thenAnswer((_) async => Response('', 200));
  });
  group('Search Page Widget Tests', () {
    testWidgets('Initial Layout Checks', (widgetTester) async {
      when(() => billSearchBloc.state).thenReturn(const BillSearchState(
        status: BillSearchStatus.initial,
      ));
      await widgetTester.pumpWidget(SearchPageWrapper(
        billSearchBloc: billSearchBloc,
        savedBillsBloc: savedBillsBloc,
      ));
      expect(find.byType(BillSearchBar), findsOneWidget);
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      expect(
          find.text(BillSearchStatus.initial.statusFeedback), findsOneWidget);
    });
    testWidgets('Searching Layout Checks', (widgetTester) async {
      when(() => billSearchBloc.state).thenReturn(const BillSearchState(
        status: BillSearchStatus.searching,
      ));
      await widgetTester.pumpWidget(SearchPageWrapper(
        billSearchBloc: billSearchBloc,
        savedBillsBloc: savedBillsBloc,
      ));
      await widgetTester.pump(Duration.zero);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('10 Bill tiles are returned', (tester) async {
      when(() => billSearchBloc.state).thenReturn(BillSearchState(
          searchBills: GovinfoBill.fromExampleKeywordSearch(),
          status: BillSearchStatus.success));
      await tester.pumpWidget(SearchPageWrapper(
        billSearchBloc: billSearchBloc,
        savedBillsBloc: savedBillsBloc,
      ));
      final listFinder = find.byType(Scrollable);
      for (final bill in savedBillsBloc.state.bills) {
        await tester.scrollUntilVisible(
          find.byKey(ValueKey(bill.billId)),
          500.0,
          scrollable: listFinder,
        );
        expect(find.byKey(ValueKey(bill.billId)), findsOneWidget);
      }
    });
  });
}

class SearchPageWrapper extends StatelessWidget {
  SearchPageWrapper(
      {Key? key,
      required this.billSearchBloc,
      required this.savedBillsBloc,
      billApiProvider})
      : super(key: key);
  final BillSearchBloc billSearchBloc;
  final SavedBillsBloc savedBillsBloc;
  final BillApiProvider billApiProvider = GovinfoApi(client: MockHttpClient());

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => billApiProvider,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: billSearchBloc,
          ),
          BlocProvider.value(
            value: savedBillsBloc,
          ),
        ],
        child: const MaterialApp(
          home: BillSearchPage(),
        ),
      ),
    );
  }
}
