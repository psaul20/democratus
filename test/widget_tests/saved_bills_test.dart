import 'dart:io';
import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/bloc_states/bill_search_status.dart';
import 'package:democratus/globals/enums/bloc_states/saved_bills_status.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:democratus/pages/bill_search_page.dart';
import 'package:democratus/pages/home_page.dart';
import 'package:democratus/widgets/bill_sliver_list.dart';
import 'package:democratus/widgets/bill_tile.dart';
import 'package:democratus/widgets/search_widgets/bill_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks.dart';

Future<void> main() async {
  late MockSavedBillsBloc savedBillsBloc;

  setUpAll(() {
    initHydratedStorage();
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
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
      await tester.pump(Duration.zero);
      expect(find.byType(BillTile), findsNWidgets(10));
    });
  });
}

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({Key? key, required this.savedBillsBloc})
      : super(key: key);
  final SavedBillsBloc savedBillsBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: savedBillsBloc,
        ),
      ],
      child: const MaterialApp(home: HomePage(title: 'MY BILLS')),
    );
  }
}
