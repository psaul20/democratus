// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/package_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Basing Riverpod implementation off of https://www.youtube.com/watch?v=Zp7
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

final queryParamsProvider = StateProvider<Map>((ref) {
  final Map<String, String?> queryParams = {};
  queryParams["collectionCode"] =
      ref.watch(selectedCollectionProvider)?.collectionCode;
  return queryParams;
});

final packagesProvider = StateProvider<List<Package>>((ref) => []);

class SearchPackages extends ConsumerWidget {
  const SearchPackages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Documents"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose a Collection:",
              textAlign: TextAlign.left,
            ),
            const CollectionsDropDownBuilder(),
            const Text('Published after date:'),
            TextField(
              onSubmitted: (value) {
                ref.read(queryParamsProvider.notifier).state['startDate'] =
                    value;
              },
            ),
            const SearchPackagesBuilder(),
          ],
        ),
      ),
      floatingActionButton: const SearchButtonBuilder(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CollectionsDropDownBuilder extends ConsumerWidget {
  const CollectionsDropDownBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Collection>> collections = ref.watch(collectionsProvider);
    String? dropDownValue =
        ref.watch(selectedCollectionProvider)?.collectionName;
    //TODO: Error handling
    return collections.when(data: ((collections) {
      return DropdownButton<String>(
        isExpanded: true,
        value: dropDownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          int idx = collections
              .indexWhere((element) => element.collectionName == value);
          ref.read(selectedCollectionProvider.notifier).state =
              collections.elementAt(idx);
        },
        items: collections.map<DropdownMenuItem<String>>((element) {
          return DropdownMenuItem<String>(
            value: element.collectionName,
            child: Text(element.collectionName),
          );
        }).toList(),
      );
    }), error: (Object error, StackTrace stackTrace) {
      return (Text("{$error}"));
    }, loading: () {
      return const Text("Fetching Collections");
    });
  }
}

class SearchPackagesBuilder extends ConsumerWidget {
  const SearchPackagesBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Package> packages = ref.watch(packagesProvider);
    Widget returnWidget;
    if (packages.isEmpty) {
      returnWidget = const Expanded(
        child: Center(
            child: Text(
          "Tap below to Search",
          textAlign: TextAlign.center,
        )),
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
    double iconSize = 50.0;
    List<Package> packages = ref.watch(packagesProvider);
    if (packages.isEmpty) {
      return IconButton(
        icon: const Icon(Icons.search),
        // TODO: Move out of onPressed to clean up - possibly convert to stateful
        onPressed: () async {
          DateTime startDate =
              DateTime.parse(ref.read(queryParamsProvider)['startDate']);
          String collectionCode =
              ref.read(queryParamsProvider)['collectionCode'];
          PackageList packages = await GovinfoApi().searchPackages(
              startDate: startDate, collectionCodes: [collectionCode]);
          ref.read(packagesProvider.notifier).state = packages.packages;
        },
        iconSize: iconSize,
      );
    } else {
      return IconButton(
        onPressed: () => packages = [],
        icon: const Icon(Icons.remove),
        iconSize: iconSize,
      );
    }
  }
}

// class CollectionDropDown extends StatefulWidget {
//   const CollectionDropDown({super.key, required this.collections});
//   final CollectionList collections;

//   @override
//   State<CollectionDropDown> createState() => _CollectionDropDownState();
// }

// class _CollectionDropDownState extends State<CollectionDropDown> {
//   late List<String> names;
//   late String dropDownValue;
//   late Collection selectedCollection;

//   @override
//   void initState() {
//     names = widget.collections.getCollectionNames();
//     dropDownValue = names.first;
//     selectedCollection = widget.collections._collections.first;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
