// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/models/packages_provider.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/styles/theme_data.dart';
import 'package:democratus/widgets/date_input/date_picker.dart';
import 'package:democratus/widgets/dropdowns.dart';
import 'package:democratus/widgets/package_widgets/package_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// TODO: Consolidate providers?
// TODO: Update search to load 10 at a time, not just 10
// TODO: Sort by last action date
// TODO: Search by text
// TODO: Make search parameters a drawer/Sliverlist
// TODO: Fix search/remove button look and feel (possible as an overlay)
// TODO: Hero animation transition
// TODO: Reader page
// TODO: Better date specification//Basing Riverpod implementation off of https://www.youtube.com/watch?v=Zp7
final collectionsProvider = FutureProvider<List<Collection>>((ref) async {
  CollectionList collections = await GovinfoApi().getCollections();
  return collections.asList;
});

final selectedCollectionProvider = StateProvider<Collection?>((ref) {
  final collections = ref.watch(collectionsProvider);
  if (collections.hasValue) {
    return collections.value?.first;
  }
  return null;
});

final startDateInputProvider = StateProvider<DateTime?>(
  (ref) => null,
);

final endDateInputProvider = StateProvider<DateTime?>(
  (ref) => null,
);

final queryParamsProvider = StateProvider<Map>((ref) {
  final Map<String, String?> queryParams = {};
  queryParams["collectionCode"] =
      ref.watch(selectedCollectionProvider)?.collectionCode;
  queryParams["startDate"] = ref.watch(startDateInputProvider).toString();
  queryParams["endDate"] = ref.watch(endDateInputProvider).toString();
  return queryParams;
});

final canSearchProvider = StateProvider<bool>((ref) {
  bool canSearch = false;
  if (ref.watch(selectedCollectionProvider) != null &&
      ref.watch(startDateInputProvider) != null &&
      ref.watch(endDateInputProvider) != null) {
    canSearch = true;
  }
  return canSearch;
});

final packagesProvider = StateNotifierProvider<PackagesProvider, List<Package>>(
    (ref) => PackagesProvider([]));

class SearchPackagesPage extends ConsumerWidget {
  const SearchPackagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Collection>? collections = ref.read(collectionsProvider).asData?.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Documents"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose a Collection",
              textAlign: TextAlign.left,
              style: TextStyles.fieldTitle,
            ),
            AsyncDropDownBuilder(
              provider: collectionsProvider,
              dropDownValue:
                  ref.watch(selectedCollectionProvider)?.collectionName,
              onChanged: (String? value) {
                if (collections != null) {
                  int? idx = collections
                      .indexWhere((element) => element.collectionName == value);
                  ref.read(selectedCollectionProvider.notifier).state =
                      collections.elementAt(idx);
                }
              },
              mapFunction: (element) {
                return DropdownMenuItem<String>(
                  value: element.collectionName,
                  child: Text(
                    element.collectionName,
                    style: TextStyles.inputStyle,
                  ),
                );
              },
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    children: [
                      Text(
                        'Published After',
                        style: TextStyles.fieldTitle,
                      ),
                      MyDatePicker(dateProvider: startDateInputProvider),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Published Before',
                      style: TextStyles.fieldTitle,
                    ),
                    MyDatePicker(
                      dateProvider: endDateInputProvider,
                      afterDateProvider: startDateInputProvider,
                    ),
                  ],
                ),
              ],
            ),
            const SearchPackagesBuilder(),
          ],
        ),
      ),
      floatingActionButton: const SearchButtonBuilder(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class SearchPackagesBuilder extends ConsumerWidget {
  const SearchPackagesBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool canSearch = ref.watch(canSearchProvider);
    List<Package> packages = ref.watch(packagesProvider);
    Widget returnWidget;
    if (packages.isEmpty) {
      returnWidget = Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
            child: canSearch
                ? const Text(
                    "Tap below to search.",
                    textAlign: TextAlign.center,
                  )
                : const Text("Fill out the search fields above.")),
      );
    } else {
      returnWidget =
          Expanded(child: PackageListView(packagesProvider: packagesProvider));
    }
    return returnWidget;
  }
}

class SearchButtonBuilder extends ConsumerWidget {
  const SearchButtonBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void submitSearch() async {
      DateTime startDate =
          DateTime.parse(ref.read(queryParamsProvider)['startDate']);
      DateTime? endDate =
          DateTime.parse(ref.read(queryParamsProvider)['endDate']);
      String collectionCode = ref.read(queryParamsProvider)['collectionCode'];
      PackageList packages = await GovinfoApi().searchPackages(
          startDate: startDate,
          endDate: endDate,
          collectionCodes: [collectionCode]);
      ref.read(packagesProvider.notifier).replacePackages(packages.packages);
    }

    void removeSearch() {
      ref.read(packagesProvider.notifier).replacePackages([]);
    }

    double iconSize = 50.0;
    List<Package> packages = ref.watch(packagesProvider);
    bool canSearch = ref.watch(canSearchProvider.notifier).state;
    Color iconColor = DemocScheme.scheme.onBackground;
    if (packages.isEmpty) {
      return IconButton(
        icon: const Icon(Icons.search_outlined),
        onPressed: canSearch ? submitSearch : null,
        iconSize: iconSize,
        color: iconColor,
      );
    } else {
      return IconButton(
        onPressed: removeSearch,
        icon: const Icon(Icons.highlight_remove),
        iconSize: iconSize,
        color: iconColor,
      );
    }
  }
}
