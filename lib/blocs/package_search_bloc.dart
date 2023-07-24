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

final class SubmitSearch extends PackageSearchEvent {}

final class ClearSearch extends PackageSearchEvent {}

final class GetCollections extends PackageSearchEvent {}

//TODO: Likely need to store readiness as a state variable
//TODO: Handle no results retrieved
enum PackageSearchStatus { initial, success, failure }

class PackageSearchState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<Collection> collections;
  final Collection? selectedCollection;
  final PackageSearchStatus status;
  final List<Package> searchPackages;
  final bool isReady;

  const PackageSearchState(
      {this.startDate,
      this.endDate,
      this.collections = const <Collection>[],
      this.selectedCollection,
      this.status = PackageSearchStatus.initial,
      this.isReady = false,
      this.searchPackages = const <Package>[]});

  @override
  List<Object?> get props => [
        collections,
        selectedCollection,
        startDate,
        endDate,
        status,
        isReady,
        searchPackages,
      ];

  List<Object?> get reqFields => [
        collections,
        selectedCollection,
      ];

  PackageSearchState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<Collection>? collections,
    Collection? selectedCollection,
    PackageSearchStatus? status,
    List<Package>? searchPackages,
    bool? isReady,
  }) {
    return PackageSearchState(
        startDate: startDate,
        endDate: endDate,
        collections: collections ?? this.collections,
        selectedCollection: selectedCollection ?? this.selectedCollection,
        status: status ?? this.status,
        searchPackages: searchPackages ?? this.searchPackages,
        isReady: isReady ?? this.isReady);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (startDate != null) {
      map['startDate'] = startDate!.millisecondsSinceEpoch;
    }
    if (startDate != null) {
      map['endDate'] = endDate!.millisecondsSinceEpoch;
    }
    map['collections'] = collections.map((x) => x.toMap()).toList();
    map['selectedCollection'] = selectedCollection?.toMap();
    map['searchPackages'] = searchPackages.map((x) => x.toMap()).toList();
    map['isReady'] = isReady;
    return map;
  }

  factory PackageSearchState.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return const PackageSearchState();
    } else {
      List<Package> searchPackages = List<Package>.from(
          (map['searchPackages'] as List<dynamic>).map<Package>(
        (x) => Package.fromMap(x as Map<String, dynamic>),
      ));
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
        status: searchPackages.isNotEmpty
            ? PackageSearchStatus.success
            : PackageSearchStatus.initial,
        searchPackages: searchPackages.isNotEmpty ? searchPackages : [],
        isReady: map['isReady'] as bool,
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory PackageSearchState.fromJson(String source) =>
      PackageSearchState.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PackageSearchBloc
    extends HydratedBloc<PackageSearchEvent, PackageSearchState> {
  PackageSearchBloc() : super(const PackageSearchState()) {
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
    on<SubmitSearch>(_submitSearch);
    on<GetCollections>(_getCollections);
    on<PackageSearchEvent>(
      (event, emit) {
        emit(state.copyWith(isReady: _checkReady()));
      },
    );
  }

  bool _checkReady() {
    return state.reqFields.contains(null) ? false : true;
  }

  Future<void> _submitSearch(event, emit) async {
    if (state.isReady) {
      try {
        List<Package> packages = await _fetchPackageSearch();
        emit(state.copyWith(
          searchPackages: packages,
          status: PackageSearchStatus.success,
        ));
      } catch (_) {
        emit(state.copyWith(status: PackageSearchStatus.failure));
      }
    } else {
      throw Exception('Search not Ready');
    }
  }

  Future<List<Package>> _fetchPackageSearch() async {
    Response response = await GovinfoApi().searchPackages(
        startDate: state.startDate ?? DateTime(1776, 7, 4),
        endDate: state.endDate ?? DateTime.now(),
        size: 100,
        collectionCodes: [state.selectedCollection!.collectionCode]);
    if (response.statusCode == 200) {
      log("Search query successful");
      Map body = jsonDecode(response.body) as Map<String, dynamic>;
      int count = body['count'];
      if (count > 0) {
        return PackageList.fromJson(response.body).packages;
      } else {
        //TODO: Fix search package retriever widget to handle no results retrieved
        throw Exception("No results retrieved");
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to retrieve package');
    }
  }

  Future<void> _getCollections(
      PackageSearchEvent event, Emitter<PackageSearchState> emit) async {
    try {
      final collections = await _fetchCollections();
      emit(state.copyWith(
          collections: collections,
          selectedCollection: state.selectedCollection ?? collections.first));
    } catch (_) {
      emit(state.copyWith(status: PackageSearchStatus.failure));
    }
  }

  Future<List<Collection>> _fetchCollections() async {
    final response = await GovinfoApi().getCollections();
    if (response.statusCode == 200) {
      return CollectionList.fromJson(response.body).asList;
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
