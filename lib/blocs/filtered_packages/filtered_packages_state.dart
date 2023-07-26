// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_packages_bloc.dart';

@immutable
class FilteredPackagesState extends Equatable {
  const FilteredPackagesState({
    required this.appliedCriteria,
    required this.filteredList,
  });

  final List<FilterCriterion> appliedCriteria;
  final List<Package> filteredList;

  FilteredPackagesState copyWith({
    List<FilterCriterion>? appliedCriteria,
    List<Package>? filteredList,
  }) {
    return FilteredPackagesState(
      appliedCriteria: appliedCriteria ?? this.appliedCriteria,
      filteredList: filteredList ?? this.filteredList,
    );
  }

  @override
  List<Object?> get props => [appliedCriteria, filteredList];
}

class FilteredPackagesInitial extends FilteredPackagesState {
  const FilteredPackagesInitial({
    super.appliedCriteria = const <FilterCriterion>[],
    super.filteredList = const <Package>[],
  });

  @override
  List<Object?> get props => [appliedCriteria, filteredList];
}

class FilteredPackagesFailure extends FilteredPackagesState {
  const FilteredPackagesFailure(
      {required super.appliedCriteria,
      required super.filteredList,
      required this.except});

  final Exception except;

  @override
  List<Object?> get props => [appliedCriteria, filteredList, except];
}
