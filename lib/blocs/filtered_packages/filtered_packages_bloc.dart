import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filtered_packages_event.dart';
part 'filtered_packages_state.dart';

enum FilterType { text, packageType }

class FilteredPackagesBloc
    extends Bloc<FilteredPackagesEvent, FilteredPackagesState> {
  FilteredPackagesBloc() : super(const FilteredPackagesInitial()) {
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
        newCriteria[FilterType.packageType] = <String>[
          ...state.appliedCriteria[FilterType.packageType],
          event.type
        ];
        emit(state.copyWith(appliedCriteria: newCriteria));
      },
    );
    on<RemoveTypeFilter>(
      (event, emit) {
        Map<FilterType, dynamic> newCriteria = Map.from(state.appliedCriteria);
        newCriteria[FilterType.packageType] = <String>[
          for (final type in newCriteria[FilterType.packageType])
            if (type != event.type) type
        ];
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
}
