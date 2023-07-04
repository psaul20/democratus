import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/models/packages_provider.dart';
import 'package:democratus/pages/search_packages_page.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/styles/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchButtonBuilder extends ConsumerWidget {
  const SearchButtonBuilder({
    super.key,
    required this.canSearchProvider,
    required this.queryParamsProvider,
    required this.packagesProvider,
  });
  final StateProvider<bool> canSearchProvider;
  final StateProvider<Map> queryParamsProvider;
  final StateNotifierProvider<PackagesProvider, List<Package>> packagesProvider;

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

    double iconSize = 45.0;
    List<Package> packages = ref.watch(packagesProvider);
    bool canSearch = ref.watch(canSearchProvider);
    Color iconColor = DemocScheme.scheme.onBackground;
    if (packages.isEmpty) {
      return Column(
        children: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: canSearch ? submitSearch : null,
            iconSize: iconSize,
            color: iconColor,
          ),
          Text(
            canSearch ? "Search" : "Complete Search Fields",
            style: TextStyles.iconText,
          )
        ],
      );
    } else {
      return Column(
        children: [
          IconButton(
            onPressed: removeSearch,
            icon: const Icon(Icons.highlight_remove),
            iconSize: iconSize,
            color: iconColor,
          ),
          Text(
            "Reset",
            style: TextStyles.iconText,
          )
        ],
      );
    }
  }
}
