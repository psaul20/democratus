// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_packages_bloc.dart';

@immutable
class FilteredPackagesState extends Equatable {
  const FilteredPackagesState({
    required this.appliedCriteria,
    required this.filteredList,
    required this.initList,
  });

  final Map<FilterType, FilterCriterion> appliedCriteria;
  final List<Package> filteredList;
  final List<Package> initList;

  FilteredPackagesState copyWith({
    Map<FilterType, FilterCriterion>? appliedCriteria,
    List<Package>? filteredList,
    List<Package>? initList,
  }) {
    return FilteredPackagesState(
      appliedCriteria: appliedCriteria ?? this.appliedCriteria,
      filteredList: filteredList ?? this.filteredList,
      initList: initList ?? this.initList,
    );
  }

  @override
  List<Object?> get props => [appliedCriteria, filteredList, initList];
}

class FilteredPackagesInitial extends FilteredPackagesState {
  const FilteredPackagesInitial({
    super.appliedCriteria = const <FilterType, FilterCriterion>{},
    super.filteredList = const <Package>[],
    super.initList = const <Package>[],
  });

  @override
  List<Object?> get props => [appliedCriteria, initList, filteredList];
}

class FilteredPackagesFailure extends FilteredPackagesState {
  const FilteredPackagesFailure(
      {required super.appliedCriteria,
      required super.filteredList,
      required super.initList,
      required this.except});

  final Exception except;

  @override
  List<Object?> get props => [appliedCriteria, filteredList, initList, except];
}
