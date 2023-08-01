import 'package:democratus/blocs/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Useable both as a search parameter and filter parameter
enum FilterLevel { search, filter }

class TypeFilterList extends StatelessWidget {
  const TypeFilterList({super.key, required this.filterLevel});
  final FilterLevel filterLevel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageSearchBloc, PackageSearchState>(
      builder: (context, state) {
        Map types = Collection
                .collectionTypes[state.selectedCollection?.collectionCode] ??
            {};
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              String typeCode = types.keys.toList()[index];
              String typeLabel = types[typeCode];
              return TypeFilterListItem(
                typeCode: typeCode,
                typeLabel: typeLabel,
                filterLevel: filterLevel,
              );
            }),
            separatorBuilder: (context, index) => Container(
                  height: 1,
                  color:
                      Theme.of(context).colorScheme.onBackground.withAlpha(100),
                ),
            itemCount: types.keys.length);
      },
    );
  }
}

class TypeFilterListItem extends StatelessWidget {
  const TypeFilterListItem(
      {super.key,
      required this.typeCode,
      required this.typeLabel,
      required this.filterLevel});
  final String typeCode;
  final String typeLabel;
  final FilterLevel filterLevel;

  @override
  Widget build(BuildContext context) {
    switch (filterLevel) {
      case FilterLevel.search:
        {
          return BlocBuilder<PackageSearchBloc, PackageSearchState>(
            buildWhen: (previous, current) =>
                previous.docClasses != current.docClasses,
            builder: (context, state) {
              List<String> appliedTypeFilters = state.docClasses;
              bool isFiltered =
                  appliedTypeFilters.contains(typeCode) ? true : false;
              toggleFilter() {
                isFiltered
                    ? context
                        .read<PackageSearchBloc>()
                        .add(RemoveDocClass(typeCode))
                    : context
                        .read<PackageSearchBloc>()
                        .add(AddDocClass(typeCode));
              }

              return TypeFilterButton(
                isFiltered: isFiltered,
                typeLabel: typeLabel,
                onPressed: toggleFilter,
              );
            },
          );
        }
      case FilterLevel.filter:
        {
          return BlocBuilder<FilteredPackagesBloc, FilteredPackagesState>(
            buildWhen: (previous, current) =>
                previous.appliedCriteria != current.appliedCriteria,
            builder: (context, state) {
              bool isFiltered = (state.appliedCriteria[FilterType.packageType]
                          as List<String>)
                      .contains(typeCode)
                  ? true
                  : false;
              toggleFilter() {
                isFiltered
                    ? context
                        .read<FilteredPackagesBloc>()
                        .add(RemoveTypeFilter(type: typeCode))
                    : context
                        .read<FilteredPackagesBloc>()
                        .add(AddTypeFilter(type: typeCode));
              }

              return TypeFilterButton(
                isFiltered: isFiltered,
                typeLabel: typeLabel,
                onPressed: toggleFilter,
              );
            },
          );
        }
    }
  }
}

class TypeFilterButton extends StatelessWidget {
  const TypeFilterButton({
    super.key,
    required this.isFiltered,
    required this.typeLabel,
    required this.onPressed,
  });

  final bool isFiltered;
  final String typeLabel;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: const ButtonStyle().copyWith(alignment: Alignment.centerLeft),
      onPressed: onPressed,
      icon: Icon(
          isFiltered ? Icons.check_box : Icons.check_box_outline_blank_rounded),
      label: Text(
        typeLabel,
      ),
    );
  }
}
