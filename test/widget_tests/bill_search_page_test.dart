import 'dart:io';

import 'package:democratus/api/pro_publica_api.dart';
import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_search_status.dart';
import 'package:democratus/pages/bill_search_page.dart';
import 'package:democratus/widgets/bill_sliver_list.dart';
import 'package:democratus/widgets/search_widgets/bill_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import '../bloc_tests/bill_search_bloc_test.mocks.dart';
import '../mocks.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  Client realClient = Client();
  MockClient mockClient = MockClient();

  setUp(() {
    initHydratedStorage();
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  });
  group('Search Page Widget Tests', () {
    testWidgets('Initial Layout Checks', (widgetTester) async {
      await widgetTester.pumpWidget(
        BlocProvider(
          create: (context) => BillSearchBloc(client: mockClient),
          child: const MaterialApp(
            home: BillSearchPage(),
          ),
        ),
      );
      expect(find.byType(BillSearchBar), findsOneWidget);
      expect(find.byType(BillSliverList), findsOneWidget);
      expect(
          find.text(BillSearchStatus.initial.statusFeedback), findsOneWidget);
    });
    testWidgets('20 Bill tiles are returned', (tester) async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => ProPublicaApi.getBillByKeyword(
              keyword: 'climate', client: realClient));

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => BillSearchBloc(client: mockClient)
            ..add(KeywordSearch(keyword: 'climate')),
          child: const MaterialApp(
            home: BillSearchPage(),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 5));
      expect(find.byType(BillSliverList), findsOneWidget);
      // expect(find.byType(BillTile), findsNWidgets(20));
    });
  });
}
