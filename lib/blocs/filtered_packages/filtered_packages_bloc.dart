import 'package:democratus/models/filter_criteria.dart';
import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filtered_packages_event.dart';
part 'filtered_packages_state.dart';

//TODO: Implement in UI
class FilteredPackagesBloc
    extends Bloc<FilteredPackagesEvent, FilteredPackagesState> {
  FilteredPackagesBloc() : super(const FilteredPackagesInitial()) {
    //TODO: May be a better way to manage this besides maps from classes
    on<AddFilter>((event, emit) {
      Map<FilterType, FilterCriterion> newCriteria =
          Map.from(state.appliedCriteria);
      newCriteria[event.criterion.type] = event.criterion;
      emit(state.copyWith(
        appliedCriteria: newCriteria,
      ));
    });
    on<InitPackages>(
      (event, emit) => emit(state.copyWith(initList: event.packages)),
    );
    on<FilteredPackagesEvent>(_applyFilters);
  }

  void _applyFilters(
      FilteredPackagesEvent event, Emitter<FilteredPackagesState> emit) {
    List<Package> newFilterPackages = state.initList;

    for (var criterion in state.appliedCriteria.entries) {
      switch (criterion.key) {
        case FilterType.text:
          String filterString = criterion.value.data as String;
          filterString = filterString.toLowerCase();
          if (filterString != '') {
            newFilterPackages = newFilterPackages
                .where((package) =>
                    package.searchText.toLowerCase().contains(filterString))
                .toList();
          } else {}

        default:
      }
    }
    emit(state.copyWith(filteredList: newFilterPackages));
  }
}
