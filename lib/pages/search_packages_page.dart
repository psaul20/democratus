// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/models/packages_provider.dart';
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/package_widgets/package_list_column.dart';
import 'package:democratus/widgets/package_widgets/package_list_view.dart';
import 'package:democratus/widgets/package_widgets/package_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    List<Package> packages = ref.watch(packagesProvider);
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("Search Documents"),
          //TODO: Figure out how to make this flexible size
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(240), child: PackageSearchBar()),
          floating: true,
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          [
            //TODO: Update with fetch data button while fetching
            packages.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      PackageListColumn(packagesProvider: packagesProvider),
                    ],
                  )
          ],
        ))
      ]),
    );
  }
}
