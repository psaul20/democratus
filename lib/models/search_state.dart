// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_import

import 'dart:convert';

import 'collection.dart';
import 'package.dart';

class SearchState {
  // final List<Package> packages;
  // final DateTime startDate;
  // final DateTime endDate;
  final List<Collection> collections;
  // final Map<String, String> queryParams;
  final Collection? selectedCollection;
  // final bool isCodeSelected;
  // final bool isDateInput;
  // final bool isSearching;
  SearchState({
    this.selectedCollection,
    required this.collections,
  });

  SearchState.initialState()
      : collections = const <Collection>[],
        selectedCollection = null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'collections': collections.map((x) => x.toMap()).toList(),
      'selectedCollection': selectedCollection?.toMap(),
    };
  }

  factory SearchState.fromMap(Map<String, dynamic> map) {
    return SearchState(
      collections: List<Collection>.from((map['collections'] as List<int>).map<Collection>((x) => Collection.fromMap(x as Map<String,dynamic>),),),
      selectedCollection: map['selectedCollection'] != null ? Collection.fromMap(map['selectedCollection'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchState.fromJson(String source) => SearchState.fromMap(json.decode(source) as Map<String, dynamic>);
}
