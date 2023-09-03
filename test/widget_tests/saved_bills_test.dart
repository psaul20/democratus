// ignore_for_file: unused_import

import 'dart:io';
import 'package:democratus/api/bills_api_provider.dart';
import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/saved_bills_status.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:democratus/pages/home_page.dart';
import 'package:democratus/widgets/bill_tile.dart';
import 'package:democratus/widgets/home_page_widgets/home_page_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import '../mocks.dart';

Future<void> main() async {
  late MockSavedBillsBloc savedBillsBloc;

  setUpAll(() {
    initHydratedStorage();
    registerFallbackValue(Uri.parse('google.com'));
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    Client client = MockHttpClient();
    when(() => client.get(any())).thenAnswer((_) async => Response('', 200));
    savedBillsBloc = MockSavedBillsBloc();
  });
  group('Home Page Widget Tests', () {
    testWidgets('Initial Layout Checks', (widgetTester) async {
      when(() => savedBillsBloc.state).thenReturn(const SavedBillsState());
      await widgetTester.pumpWidget(HomePageWrapper(
        savedBillsBloc: savedBillsBloc,
      ));
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      expect(
          find.text(SavedBillsStatus.initial.statusFeedback), findsOneWidget);
    });
    testWidgets('10 Bill tiles are returned', (tester) async {
      when(() => savedBillsBloc.state).thenReturn(SavedBillsState(
          bills: ProPublicaBill.fromExampleKeywordSearch(),
          status: SavedBillsStatus.success));
      await tester.pumpWidget(HomePageWrapper(
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

      // Scroll until the item to be found appears.
    });
  });
}

class HomePageWrapper extends StatelessWidget {
  HomePageWrapper({Key? key, required this.savedBillsBloc, billApiProvider})
      : super(key: key);
  final SavedBillsBloc savedBillsBloc;
  final BillApiProvider billApiProvider =
      ProPublicaApi(client: MockHttpClient());

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => billApiProvider,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: savedBillsBloc,
          ),
        ],
        child: const MaterialApp(home: HomePage(title: 'MY BILLS')),
      ),
    );
  }
}
