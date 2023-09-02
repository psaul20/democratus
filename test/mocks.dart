import 'package:bloc_test/bloc_test.dart';
import 'package:democratus/blocs/bill_bloc/bill_bloc.dart';
import 'package:democratus/blocs/bill_search_bloc/bill_search_bloc.dart';
import 'package:democratus/blocs/client_cubit/client_cubit.dart';
import 'package:democratus/blocs/saved_bills_bloc/saved_bills_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockStorage extends Mock implements Storage {}

class MockHttpClient extends Mock implements http.Client {}

class MockBillSearchBloc extends MockBloc<BillSearchEvent, BillSearchState> implements BillSearchBloc {}

class FakeBillSearchEvent extends Fake implements BillSearchEvent {}

class FakeBillSearchState extends Fake implements BillSearchState {}

class MockSavedBillsBloc extends MockBloc<SavedBillsEvent, SavedBillsState> implements SavedBillsBloc {}

class FakeSavedBillsEvent extends Fake implements SavedBillsEvent {}

class FakeSavedBillsState extends Fake implements SavedBillsState {}

class MockClientCubit extends MockCubit<ClientState> implements ClientCubit {
}

class FakeClientState extends Fake implements ClientState {}

class MockBillBloc extends MockBloc<BillEvent, BillState> implements BillBloc {}

class FakeBillEvent extends Fake implements BillEvent {}

class FakeBillState extends Fake implements BillState {}

late Storage hydratedStorage;

void initHydratedStorage() {
  TestWidgetsFlutterBinding.ensureInitialized();
  hydratedStorage = MockStorage();
  when(
    () => hydratedStorage.write(any(), any<dynamic>()),
  ).thenAnswer((_) async {});
  HydratedBloc.storage = hydratedStorage;
}
