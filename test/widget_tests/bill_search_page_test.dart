import 'dart:io';
import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_search_status.dart';
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
import '../bloc_tests/bill_search_bloc_test.mocks.dart';
import '../mocks.dart';

Future<void> main() async {
  late MockBillSearchBloc billSearchBloc;
  late MockSavedBillsBloc savedBillsBloc;

  setUpAll(() {
    initHydratedStorage();
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    billSearchBloc = MockBillSearchBloc();
    savedBillsBloc = MockSavedBillsBloc();
    when(() => savedBillsBloc.state).thenReturn(const SavedBillsState());
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
    testWidgets('20 Bill tiles are returned', (tester) async {
      when(() => billSearchBloc.state).thenReturn(BillSearchState(
          searchBills: ProPublicaBill.fromExampleKeywordSearch(),
          status: BillSearchStatus.success));
      await tester.pumpWidget(SearchPageWrapper(
        billSearchBloc: billSearchBloc,
        savedBillsBloc: savedBillsBloc,
      ));
      await tester.pump(Duration.zero);
      expect(find.byType(BillSliverList), findsOneWidget);
      expect(find.byType(BillTile, skipOffstage: false), findsNWidgets(10));
    });
  });
}

class SearchPageWrapper extends StatelessWidget {
  const SearchPageWrapper(
      {Key? key, required this.billSearchBloc, required this.savedBillsBloc})
      : super(key: key);
  final BillSearchBloc billSearchBloc;
  final SavedBillsBloc savedBillsBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
    );
  }
}
