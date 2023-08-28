import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:democratus/globals/enums/errors.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/models/bill_models/pro_publica_bill.dart';
import 'package:democratus/widgets/bill_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../bloc_tests/bill_search_bloc_test.mocks.dart';
import '../mocks.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  Bill bill = ProPublicaBill.fromExample();
  late MockClient client;
  late BillBloc billBloc;
  late SavedBillsBloc savedBillsBloc;
  setUp(() {
    initHydratedStorage();
    client = MockClient();
    billBloc = BillBloc(bill: bill, client: client);
    savedBillsBloc = SavedBillsBloc();
    savedBillsBloc.add(ReplaceBills(bills: [bill]));
  });
  group('BillTile widget tests', () {
    testWidgets('BillTile has a title', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: BillTile(savedBillsBloc: savedBillsBloc, billBloc: billBloc)));
      expect(find.text(bill.displayTitle), findsOneWidget);
    });
    testWidgets('BillTile shows an error', (tester) async {
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((realInvocation) async => Response('', 404));

      await tester.pumpWidget(MaterialApp(
          home: BillTile(savedBillsBloc: savedBillsBloc, billBloc: billBloc)));
      expect(find.text(errorMessages[Errors.dataFetchError]!), findsOneWidget);
    });
  });
}
