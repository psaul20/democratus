// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/styles/theme_data.dart';
import 'package:democratus/widgets/dropdowns.dart';
import 'package:democratus/widgets/package_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Basing Riverpod implementation off of https://www.youtube.com/watch?v=Zp7
final collectionsProvider = FutureProvider<List<Collection>>((ref) async {
  CollectionList collections = await GovinfoApi().getCollections();
  return collections.asList;
});

// TODO: Consolidate providers?
final selectedCollectionProvider = StateProvider<Collection?>((ref) {
  final collections = ref.watch(collectionsProvider);
  if (collections.hasValue) {
    return collections.value?.first;
  }
  return null;
});

final dateInputProvider = StateProvider<DateTime?>(
  (ref) => null,
);

final queryParamsProvider = StateProvider<Map>((ref) {
  final Map<String, String?> queryParams = {};
  queryParams["collectionCode"] =
      ref.watch(selectedCollectionProvider)?.collectionCode;
  queryParams["startDate"] = ref.watch(dateInputProvider).toString();
  return queryParams;
});

final canSearchProvider = StateProvider<bool>((ref) {
  bool canSearch = false;
  if (ref.watch(selectedCollectionProvider) != null &&
      ref.watch(dateInputProvider) != null) {
    canSearch = true;
  }
  return canSearch;
});

final packagesProvider = StateProvider<List<Package>>((ref) => []);

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
            Text(
              'Published After',
              style: TextStyles.fieldTitle,
            ),
            const DateTextField(),
            const SearchPackagesBuilder(),
          ],
        ),
      ),
      floatingActionButton: const SearchButtonBuilder(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class DateTextField extends ConsumerStatefulWidget {
  const DateTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends ConsumerState<DateTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        style: TextStyles.inputStyle,
        // inputFormatters: [
        // Not working with iOS Simulator on Mac
        // FilteringTextInputFormatter.allow(RegExp(r'^\d{4}-\d{2}-\d{2}$')),
        // ],
        decoration: const InputDecoration(
          hintText: "Format: 1776-04-07",
        ),
        validator: (value) {
          if (value != null && DateTime.tryParse(value) != null) {
            return null;
          } else if (value == null) {
            return null;
          } else {
            return "Format must be YYYY-MM-DD";
          }
        },
        onChanged: (value) {
          if (_formKey.currentState!.validate()) {
            ref.read(dateInputProvider.notifier).state = DateTime.parse(value);
          } else {
            ref.read(dateInputProvider.notifier).state = null;
          }
        },
      ),
    );
  }
}

class SearchPackagesBuilder extends ConsumerWidget {
  const SearchPackagesBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Package> packages = ref.watch(packagesProvider);
    bool canSearch = ref.watch(canSearchProvider);
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
      returnWidget = Expanded(child: PackageListView(packages: packages));
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
      String collectionCode = ref.read(queryParamsProvider)['collectionCode'];
      PackageList packages = await GovinfoApi().searchPackages(
          startDate: startDate, collectionCodes: [collectionCode]);
      ref.read(packagesProvider.notifier).state = packages.packages;
    }

    void removeSearch() {
      ref.read(packagesProvider.notifier).state = [];
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
