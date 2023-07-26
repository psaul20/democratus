// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_packages_bloc.dart';

@immutable
abstract class FilteredPackagesEvent {}

final class AddFilter extends FilteredPackagesEvent {
  final FilterCriterion criterion;
  AddFilter({
    required this.criterion,
  });
}

final class InitPackages extends FilteredPackagesEvent {
  final List<Package> packages;

  InitPackages(this.packages);
}

//TODO: Implement removefilters
final class RemoveFilters extends FilteredPackagesEvent {}
