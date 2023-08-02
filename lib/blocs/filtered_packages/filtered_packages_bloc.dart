import 'dart:convert';
import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'filtered_packages_event.dart';
part 'filtered_packages_state.dart';

//TODO: Reverse checkbox logic on docClassFilter

class FilteredPackagesBloc
    extends HydratedBloc<FilteredPackagesEvent, FilteredPackagesState> {
  final String blocId;

  @override
  String get id => blocId;

  FilteredPackagesBloc({required this.blocId})
      : super(FilteredPackagesState()) {
    on<UpdateTextFilter>(
      (event, emit) {
        emit(state.copyWith(textFilter: event.text));
      },
    );
    on<AddDocClassFilter>(
      (event, emit) {
        List<String> newDocClasses = [...state.docClassFilter, event.docClass];
        emit(state.copyWith(docClassFilter: newDocClasses));
      },
    );
    on<RemoveDocClassFilter>(
      (event, emit) {
        List<String> newDocClasses = [
          for (final docClass in state.docClassFilter)
            if (docClass != event.docClass) docClass
        ];
        emit(state.copyWith(docClassFilter: newDocClasses));
      },
    );
    on<InitPackages>(
      (event, emit) => emit(state.copyWith(initList: event.packages)),
    );
    on<UpdateStartDateFilter>(
      (event, emit) => emit(state.copyWith(startDateFilter: event.date)),
    );
    on<UpdateEndDateFilter>(
      (event, emit) => emit(state.copyWith(endDateFilter: event.date)),
    );
    // Every event will run the apply filters
    on<FilteredPackagesEvent>(_applyFilters);
  }

  void _applyFilters(
      FilteredPackagesEvent event, Emitter<FilteredPackagesState> emit) {
    List<Package> newFilterPackages = state.initList;
    String filterString = state.textFilter.toLowerCase();
    if (filterString != '') {
      newFilterPackages = newFilterPackages
          .where((package) =>
              package.searchText.toLowerCase().contains(filterString))
          .toList();
      if (state.docClassFilter.isNotEmpty) {
        newFilterPackages = newFilterPackages
            .where((package) => state.docClassFilter.contains(package.docClass))
            .toList();
      }
      newFilterPackages = newFilterPackages
          .where((package) =>
              package.dateIssued.isAfter(state.startDateFilter) &&
              package.dateIssued.isBefore(state.endDateFilter))
          .toList();
    }
    emit(state.copyWith(filteredList: newFilterPackages));
  }

  @override
  FilteredPackagesState? fromJson(Map<String, dynamic> json) {
    return FilteredPackagesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(FilteredPackagesState state) {
    return state.toMap();
  }
}
