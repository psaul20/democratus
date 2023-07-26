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
    on<AddFilter>((event, emit) {
      emit(state.copyWith(
        appliedCriteria: [...state.appliedCriteria, event.criterion],
      ));
    });
    on<InitPackages>(
      (event, emit) => emit(state.copyWith(filteredList: event.packages)),
    );
    on<FilteredPackagesEvent>(_applyFilters);
  }

  void _applyFilters(
      FilteredPackagesEvent event, Emitter<FilteredPackagesState> emit) {
    List<Package> newFilterPackages = state.filteredList;

    for (var criterion in state.appliedCriteria) {
      switch (criterion.type) {
        case FilterType.text:
          String filterString = criterion.data as String;
          if (filterString != '') {
            newFilterPackages = newFilterPackages
                .where((package) =>
                    package.searchText.contains(criterion.data as String))
                .toList();
          } else {}

        default:
      }

      emit(state.copyWith(filteredList: newFilterPackages));
    }
  }
}
