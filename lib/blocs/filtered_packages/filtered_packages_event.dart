// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_packages_bloc.dart';

@immutable
abstract class FilteredPackagesEvent {}

final class UpdateTextFilter extends FilteredPackagesEvent {
  final String text;
  UpdateTextFilter({
    required this.text,
  });
}

class AddDocClassFilter extends FilteredPackagesEvent {
  final String docClass;
  AddDocClassFilter({
    required this.docClass,
  });
}

class RemoveDocClassFilter extends FilteredPackagesEvent {
  final String docClass;
  RemoveDocClassFilter({
    required this.docClass,
  });
}

class UpdateStartDateFilter extends FilteredPackagesEvent {
  final DateTime date;
  UpdateStartDateFilter(this.date);
}

class UpdateEndDateFilter extends FilteredPackagesEvent {
  final DateTime date;
  UpdateEndDateFilter(this.date);
}

final class InitPackages extends FilteredPackagesEvent {
  final List<Package> packages;

  InitPackages(this.packages);
}
