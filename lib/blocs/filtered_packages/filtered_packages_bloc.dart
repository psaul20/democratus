import 'dart:convert';
import 'package:democratus/models/package.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'filtered_packages_event.dart';
part 'filtered_packages_state.dart';

enum FilterType { text, packageType }

class FilteredPackagesBloc
    extends HydratedBloc<FilteredPackagesEvent, FilteredPackagesState> {
  final String blocId;

  @override
  String get id => blocId;

  FilteredPackagesBloc({required this.blocId})
      : super(const FilteredPackagesState()) {
    on<UpdateTextFilter>(
      (event, emit) {
        Map<FilterType, dynamic> newCriteria = Map.from(state.appliedCriteria);
        newCriteria[FilterType.text] = event.text;
        emit(state.copyWith(appliedCriteria: newCriteria));
      },
    );
    on<AddTypeFilter>(
      (event, emit) {
        Map<FilterType, dynamic> newCriteria = Map.from(state.appliedCriteria);
        List<String> newTypes = List.from(
            (newCriteria[FilterType.packageType] as List<String>?) ?? []);
        newTypes.add(event.type);
        newCriteria[FilterType.packageType] = newTypes;
        emit(state.copyWith(appliedCriteria: newCriteria));
      },
    );
    on<RemoveTypeFilter>(
      (event, emit) {
        Map<FilterType, dynamic> newCriteria = Map.from(state.appliedCriteria);
        List<String> newTypes = List.from(
            (newCriteria[FilterType.packageType] as List<String>?) ?? []);
        newTypes.remove(event.type);
        newCriteria[FilterType.packageType] = newTypes;
        emit(state.copyWith(appliedCriteria: newCriteria));
      },
    );
    on<InitPackages>(
      (event, emit) => emit(state.copyWith(initList: event.packages)),
    );
    // Every event will run the apply filters
    on<FilteredPackagesEvent>(_applyFilters);
  }

  void _applyFilters(
      FilteredPackagesEvent event, Emitter<FilteredPackagesState> emit) {
    List<Package> newFilterPackages = state.initList;

    for (var criterion in state.appliedCriteria.entries) {
      switch (criterion.key) {
        case FilterType.text:
          {
            String filterString = criterion.value as String;
            filterString = filterString.toLowerCase();
            if (filterString != '') {
              newFilterPackages = newFilterPackages
                  .where((package) =>
                      package.searchText.toLowerCase().contains(filterString))
                  .toList();
            }
          }
        case FilterType.packageType:
          {
            List<String> types = criterion.value as List<String>;
            if (types.isNotEmpty) {
              newFilterPackages = newFilterPackages
                  .where((package) =>
                      types.contains(package.billType ?? package.docClass))
                  .toList();
            }
          }
      }
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
