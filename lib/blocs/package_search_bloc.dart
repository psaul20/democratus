// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

sealed class PackageSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SelectCollection extends PackageSearchEvent {
  final Collection collection;
  SelectCollection({required this.collection});
}

final class SelectStartDate extends PackageSearchEvent {
  final DateTime startDate;
  SelectStartDate(this.startDate);
}

class SelectEndDate extends PackageSearchEvent {
  final DateTime endDate;
  SelectEndDate(this.endDate);
}

class AddDocClass extends PackageSearchEvent {
  final String docClass;

  AddDocClass(this.docClass);
}

class RemoveDocClass extends PackageSearchEvent {
  final String docClass;

  RemoveDocClass(this.docClass);
}

final class SubmitSearch extends PackageSearchEvent {}

final class ClearSearch extends PackageSearchEvent {}

final class GetCollections extends PackageSearchEvent {}

enum PackageSearchStatus { initial, searching, success, failure }

class PackageSearchState extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final List<Collection> collections;
  final Collection? selectedCollection;
  final PackageSearchStatus status;
  final List<Package> searchPackages;
  final List<String> docClasses;

  PackageSearchState({
    startDate,
    endDate,
    this.collections = const <Collection>[],
    this.selectedCollection,
    this.status = PackageSearchStatus.initial,
    this.searchPackages = const <Package>[],
    this.docClasses = const <String>[],
  })  : startDate = startDate ?? DateTime(1776, 7, 4),
        endDate = endDate ?? DateTime.now();

  @override
  List<Object?> get props => [
        collections,
        selectedCollection,
        startDate,
        endDate,
        status,
        searchPackages,
        docClasses
      ];

  // List<Object?> get reqFields => [
  //       collections,
  //       selectedCollection,
  //     ];

  PackageSearchState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<Collection>? collections,
    Collection? selectedCollection,
    PackageSearchStatus? status,
    List<Package>? searchPackages,
    List<String>? docClasses,
  }) {
    return PackageSearchState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      collections: collections ?? this.collections,
      selectedCollection: selectedCollection ?? this.selectedCollection,
      status: status ?? this.status,
      searchPackages: searchPackages ?? this.searchPackages,
      docClasses: docClasses ?? this.docClasses,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['startDate'] = startDate.millisecondsSinceEpoch;
    map['endDate'] = endDate.millisecondsSinceEpoch;
    map['collections'] = collections.map((x) => x.toMap()).toList();
    map['selectedCollection'] = selectedCollection?.toMap();
    map['docClasses'] = docClasses;
    return map;
  }

  factory PackageSearchState.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return PackageSearchState();
    } else {
      return PackageSearchState(
        startDate: map['startDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
            : null,
        endDate: map['endDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
            : null,
        collections: List<Collection>.from(
          (map['collections'] as List<dynamic>).map<Collection>(
            (x) => Collection.fromMap(x as Map<String, dynamic>),
          ),
        ),
        selectedCollection: map['selectedCollection'] != null
            ? Collection.fromMap(
                map['selectedCollection'] as Map<String, dynamic>)
            : null,
        status: PackageSearchStatus.initial,
        docClasses: map['docClasses'] as List<String>,
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory PackageSearchState.fromJson(String source) =>
      PackageSearchState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  String toString() {
    StringBuffer string = StringBuffer();
    string.write('Collections Length: ${collections.length}, ');
    string.write('$selectedCollection, ');
    string.write('$startDate, ');
    string.write('$endDate, ');
    string.write('$status, ');
    string.write('$collections, ');
    string.write("SearchPackages Length: ${searchPackages.length}, ");
    string.write('$docClasses');
    return string.toString();
  }
}

const int numSearchPackages = 1000;

class PackageSearchBloc
    extends HydratedBloc<PackageSearchEvent, PackageSearchState> {
  PackageSearchBloc() : super(PackageSearchState()) {
    on<SelectCollection>(
      (event, emit) {
        if (event.collection != state.selectedCollection) {
          emit(state.copyWith(
            selectedCollection: event.collection,
          ));
        } else {
          log("Collection hasn't changed, bypassing event");
        }
      },
    );
    on<SelectStartDate>(
      (event, emit) {
        emit(state.copyWith(startDate: event.startDate));
      },
    );
    on<SelectEndDate>(
      (event, emit) {
        emit(state.copyWith(endDate: event.endDate));
      },
    );
    on<ClearSearch>(
      (event, emit) {
        emit(state.copyWith(
            searchPackages: const <Package>[],
            startDate: null,
            endDate: null,
            status: PackageSearchStatus.initial));
      },
    );
    on<AddDocClass>(
      (event, emit) {
        List<String> newClasses = List.from(state.docClasses);
        newClasses.add(event.docClass);
        emit(state.copyWith(docClasses: newClasses));
      },
    );
    on<RemoveDocClass>(
      (event, emit) {
        List<String> newClasses = List.from(state.docClasses);
        newClasses.remove(event.docClass);
        emit(state.copyWith(docClasses: newClasses));
      },
    );
    on<SubmitSearch>(_submitSearch);
    on<GetCollections>(_getCollections);
  }

  Future<void> _submitSearch(event, emit) async {
    emit(state.copyWith(status: PackageSearchStatus.searching));
    try {
      List<Package> packages = await _fetchPackageSearch();
      emit(state.copyWith(
        searchPackages: packages,
        status: PackageSearchStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: PackageSearchStatus.failure));
    }
  }

  Future<List<Package>> _fetchPackageSearch() async {
    Response response = await GovinfoApi().searchPackages(
      startDate: state.startDate,
      endDate: state.endDate,
      size: numSearchPackages,
      collectionCodes: [state.selectedCollection?.collectionCode ?? 'BILLS'],
      docClasses: state.docClasses,
    );
    if (response.statusCode == 200) {
      log("Search query successful");
      Map body = jsonDecode(response.body) as Map<String, dynamic>;
      int count = body['count'];
      if (count > 0) {
        return PackageList.fromJson(response.body).packages;
      } else {
        throw Exception("No results retrieved");
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to retrieve packages');
    }
  }

  Future<void> _getCollections(
      PackageSearchEvent event, Emitter<PackageSearchState> emit) async {
    try {
      final collections = await _fetchCollections();
      //TODO: Have to update this if we provide functionality for more than bills
      emit(state.copyWith(
          collections: collections,
          selectedCollection: collections
              .singleWhere((element) => element.collectionCode == 'BILLS')));
    } catch (_) {
      emit(state.copyWith(status: PackageSearchStatus.failure));
    }
  }

  Future<List<Collection>> _fetchCollections() async {
    final response = await GovinfoApi().getCollections();
    if (response.statusCode == 200) {
      return CollectionList.fromJson(response.body).subset;
    }
    throw Exception('Error fetching Collections');
  }

  @override
  PackageSearchState? fromJson(Map<String, dynamic> json) {
    return PackageSearchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(PackageSearchState state) {
    return state.toMap();
  }
}
