import 'package:democratus/blocs/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeFilterList extends StatelessWidget {
  const TypeFilterList({super.key});

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
      {super.key, required this.typeCode, required this.typeLabel});
  final String typeCode;
  final String typeLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredPackagesBloc, FilteredPackagesState>(
      buildWhen: (previous, current) =>
          previous.appliedCriteria != current.appliedCriteria,
      builder: (context, state) {
        List<String> appliedTypeFilters =
            state.appliedCriteria[FilterType.packageType] ?? [];
        bool isFiltered = appliedTypeFilters.contains(typeCode) ? true : false;
        toggleFilter() {
          isFiltered
              ? context
                  .read<FilteredPackagesBloc>()
                  .add(RemoveTypeFilter(type: typeCode))
              : context
                  .read<FilteredPackagesBloc>()
                  .add(AddTypeFilter(type: typeCode));
        }

        return TextButton.icon(
          style: const ButtonStyle().copyWith(alignment: Alignment.centerLeft),
          onPressed: toggleFilter,
          icon: Icon(isFiltered
              ? Icons.check_box
              : Icons.check_box_outline_blank_rounded),
          label: Text(
            typeLabel,
          ),
        );
      },
    );
  }
}
