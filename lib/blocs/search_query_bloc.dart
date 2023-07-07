// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/models/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class SearchQueryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class SelectCollection extends SearchQueryEvent {
  final Collection collection;
  SelectCollection({required this.collection});
}

final class SelectStartDate extends SearchQueryEvent {
  final DateTime startDate;
  SelectStartDate(this.startDate);
}

final class SelectEndDate extends SearchQueryEvent {
  final DateTime endDate;
  SelectEndDate(this.endDate);
}

enum SearchQueryStatus { notReady, ready, searching, success, failure }

final class SearchQueryState extends Equatable {
  final Map<String, String> queryParams;
  final DateTime? startDate;
  final DateTime? endDate;
  final Collection? selectedCollection;
  final SearchQueryStatus status;

  const SearchQueryState(
      {this.queryParams = const <String, String>{},
      this.startDate,
      this.endDate,
      this.selectedCollection,
      this.status = SearchQueryStatus.notReady});

  @override
  List<Object?> get props =>
      [queryParams, startDate, endDate, selectedCollection, status];

  SearchQueryState copyWith({
    Map<String, String>? queryParams,
    DateTime? startDate,
    DateTime? endDate,
    Collection? selectedCollection,
    SearchQueryStatus? status,
  }) {
    return SearchQueryState(
      queryParams: queryParams ?? this.queryParams,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedCollection: selectedCollection ?? this.selectedCollection,
      status: status ?? this.status,
    );
  }
}

class SearchQueryBloc extends Bloc<SearchQueryEvent, SearchQueryState> {
  SearchQueryBloc() : super(const SearchQueryState()) {
    //TODO: Check if this works for every event dispatch
    on<SearchQueryEvent>(
      (event, emit) {
        bool isReady = _checkReady();
        emit(state.copyWith(
            status: isReady
                ? SearchQueryStatus.ready
                : SearchQueryStatus.notReady));
      },
    );
    on<SelectCollection>(
      (event, emit) {
        Map<String, String> newParams = state.queryParams;
        newParams['collectionCode'] = event.collection.collectionCode;
        emit(state.copyWith(selectedCollection: event.collection, queryParams: newParams));
      },
    );
    on<SelectStartDate>(
      (event, emit) {
        // Needs formatting validation & param update
        emit(state.copyWith(startDate: event.startDate));
      },
    );
    on<SelectEndDate>(
      (event, emit) {
        // needs formatting validation & param update
        emit(state.copyWith(endDate: event.endDate));
      },
    );
  }

  bool _checkReady() {
    bool isReady = true;
    state.queryParams.forEach((key, value) {
      if (value.isEmpty) {
        isReady = false;
      }
    });
    return isReady;
  }
}
