import 'package:democratus/blocs/filtered_packages/filtered_packages_bloc.dart';
import 'package:democratus/blocs/package_search_bloc.dart';
import 'package:democratus/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocClassFilterList extends StatelessWidget {
  const DocClassFilterList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredPackagesBloc, FilteredPackagesState>(
      builder: (context, state) {
        List<String> collectionCodes = state.collectionFilter;
        List<MapEntry<String, String>> docClasses = [];
        for (final collectionCode in collectionCodes) {
          docClasses = docClasses +
              Collection.docClassesByCollection(collectionCode)!
                  .entries
                  .toList();
        }
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              String typeCode = docClasses[index].key;
              String typeLabel = docClasses[index].value;
              return DocClassFilterListItem(
                docClassCode: typeCode,
                docClassLabel: typeLabel,
              );
            }),
            separatorBuilder: (context, index) => Container(
                  height: 1,
                  color:
                      Theme.of(context).colorScheme.onBackground.withAlpha(100),
                ),
            itemCount: docClasses.length);
      },
    );
  }
}

class DocClassFilterListItem extends StatelessWidget {
  const DocClassFilterListItem({
    super.key,
    required this.docClassCode,
    required this.docClassLabel,
  });

  final String docClassCode;
  final String docClassLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredPackagesBloc, FilteredPackagesState>(
      buildWhen: (previous, current) =>
          previous.docClassFilter != current.docClassFilter,
      builder: (context, state) {
        bool isFiltered =
            state.docClassFilter.contains(docClassCode) ? true : false;
        toggleFilter() {
          isFiltered
              ? context
                  .read<FilteredPackagesBloc>()
                  .add(RemoveDocClassFilter(docClass: docClassCode))
              : context
                  .read<FilteredPackagesBloc>()
                  .add(AddDocClassFilter(docClass: docClassCode));
          //TODO: Implement repository to tie these events together
          try {
            isFiltered
                ? context
                    .read<PackageSearchBloc>()
                    .add(RemoveDocClass(docClassCode))
                : context
                    .read<PackageSearchBloc>()
                    .add(AddDocClass(docClassCode));
          } catch (_) {}
        }

        return TextButton.icon(
          style: const ButtonStyle().copyWith(alignment: Alignment.centerLeft),
          onPressed: toggleFilter,
          icon: Icon(isFiltered
              ? Icons.check_box
              : Icons.check_box_outline_blank_rounded),
          label: Text(
            docClassLabel,
          ),
        );
      },
    );
  }
}
