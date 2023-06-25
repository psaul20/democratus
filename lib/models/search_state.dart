// ignore_for_file: unused_import

import 'collection.dart';
import 'package.dart';

class SearchState {
  // final List<Package> packages;
  // final DateTime startDate;
  // final DateTime endDate;
  final List<Collection> collections;
  final Map<String, String> queryParams;
  final Collection? selectedCollection;
  // final bool isCodeSelected;
  // final bool isDateInput;
  // final bool isSearching;
  SearchState({
    this.selectedCollection,
    required this.collections,
    required this.queryParams,
  });

  SearchState.initialState()
      : collections = const <Collection>[],
        queryParams = <String, String>{},
        selectedCollection = null;
}
