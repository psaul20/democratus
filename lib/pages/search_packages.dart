// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Basing Riverpod implementation off of https://www.youtube.com/watch?v=Zp7
final collectionsProvider = FutureProvider<List<Collection>>((ref) async {
  CollectionList collections = await GovinfoApi().getCollections();
  return collections.asList;
});

final selectedCollectionProvider = StateProvider<Collection?>((ref) {
  final collections = ref.watch(collectionsProvider);
  collections.whenData((data) => data.first);
  return null;
});

class SearchPackages extends ConsumerWidget {
  const SearchPackages({super.key});

  // submitSearch() async {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: Scaffold(
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
              InputDatePickerFormField(
                firstDate: DateTime(1900, 1, 1),
                lastDate: DateTime.now(),
              ),
            ],
          ),
        ),
        // floatingActionButton: const SearchButtonBuilder(),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.centerFloat,
      ),
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

// class SearchPackagesBuilder extends StatelessWidget {
//   const SearchPackagesBuilder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Widget returnWidget;
//                 if (packages._packages.isEmpty) {
//                   returnWidget = const Expanded(
//                     child: Center(
//                         child: Text(
//                       "Tap below to Search",
//                       textAlign: TextAlign.center,
//                     )),
//                   );
//                 } else {
//                   returnWidget = PackageListView(packages: packages);
//                 }
//                 return returnWidget;
//   }
// }

// class SearchButtonBuilder extends StatelessWidget {
//   const SearchButtonBuilder({super.key});

//   @override
//   Widget build(BuildContext context) {
//               double iconSize = 50.0;
//           if (packages._packages.isEmpty) {
//             return IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: submitSearch,
//               iconSize: iconSize,
//             );
//           } else {
//             return IconButton(
//               onPressed: packages.removeAll,
//               icon: const Icon(Icons.remove),
//               iconSize: iconSize,
//             );
//   }
// }

// class FeedbackWidget extends StatelessWidget {
//   const FeedbackWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

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
