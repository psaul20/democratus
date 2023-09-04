// ignore_for_file: unused_import

import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/errors.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/govinfo_bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:democratus/widgets/bill_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:democratus/globals/enums/bloc_states/bill_status.dart';

import '../mocks.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  Bill bill = GovinfoBill.fromExample();
  late MockBillBloc billBloc;
  late SavedBillsBloc savedBillsBloc;
  setUp(() {
    initHydratedStorage();
    billBloc = MockBillBloc();
    savedBillsBloc = SavedBillsBloc();
    savedBillsBloc.add(ReplaceBills(bills: [bill]));
    when(() => billBloc.state).thenReturn(BillState(bill: bill));
  });
  group('BillTile widget tests', () {
    testWidgets('BillTile has a title', (tester) async {
      await tester.pumpWidget(
          TileWrapper(savedBillsBloc: savedBillsBloc, billBloc: billBloc));
      expect(find.text(bill.displayTitle), findsOneWidget);
    });
    testWidgets('BillTile shows an error', (tester) async {
      when(() => billBloc.state)
          .thenReturn(BillState(bill: bill, status: BillStatus.failure));
      await tester.pumpWidget(
          TileWrapper(savedBillsBloc: savedBillsBloc, billBloc: billBloc));
      expect(find.text(BillStatus.failure.statusFeedback), findsOneWidget);
    });
  });
}

class TileWrapper extends StatelessWidget {
  const TileWrapper(
      {super.key, required this.savedBillsBloc, required this.billBloc});
  final SavedBillsBloc savedBillsBloc;
  final BillBloc billBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: billBloc),
      BlocProvider.value(value: savedBillsBloc)
    ], child: const MaterialApp(home: BillTile()));
  }
}
