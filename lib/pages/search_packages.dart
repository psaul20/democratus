// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/search_state.dart';
import 'package:democratus/redux/actions.dart';
import 'package:democratus/redux/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Basing redux implementation off of https://www.youtube.com/watch?v=Wj216eSBBWs
// TODO: Implement middleware for async data fetching
class SearchPackages extends StatelessWidget {
  const SearchPackages({super.key});

  // submitSearch() async {
  @override
  Widget build(BuildContext context) {
    final Store<SearchState> store = Store<SearchState>(searchStateReducer,
        initialState: SearchState.initialState());
    return StoreProvider<SearchState>(
      store: store,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search Documents"),
        ),
        body: StoreConnector<SearchState, ViewModel>(
          converter: (Store<SearchState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel vm) => Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose a Collection:",
                  textAlign: TextAlign.left,
                ),
                CollectionsDropDownBuilder(vm: vm),
                const Text('Published after date:'),
                InputDatePickerFormField(
                  firstDate: DateTime(1900, 1, 1),
                  lastDate: DateTime.now(),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: const SearchButtonBuilder(),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class ViewModel {
  final List<Collection> collections;
  // final Map<String, String> queryParams;
  final Collection? selectedCollection;
  final Function(List<Collection>) onGetCollections;
  final Function(Collection) onSelectCollection;

  ViewModel({
    this.selectedCollection,
    required this.collections,
    required this.onGetCollections,
    required this.onSelectCollection,
  });

  factory ViewModel.create(Store<SearchState> store) {
    onGetCollections(List<Collection> collections) {
      store.dispatch(GetCollectionsAction(collections));
      store.dispatch(SelectCollectionAction(collections.first));
    }

    onSelectCollection(Collection collection) {
      store.dispatch(SelectCollectionAction(collection));
    }

    return ViewModel(
      collections: store.state.collections,
      onGetCollections: onGetCollections,
      onSelectCollection: onSelectCollection,
    );
  }
}

class CollectionsDropDownBuilder extends StatefulWidget {
  const CollectionsDropDownBuilder({super.key, required this.vm});
  final ViewModel vm;

  @override
  CollectionsDropDownBuilderState createState() =>
      CollectionsDropDownBuilderState();
}

class CollectionsDropDownBuilderState
    extends State<CollectionsDropDownBuilder> {
  @override
  void initState() {
    CollectionList collections = GovinfoApi().getCollections();
    widget.vm.onGetCollections(collections.asList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Error handling
    Widget returnWidget;
    if (widget.vm.collections.isNotEmpty) {
      returnWidget = DropdownButton<String>(
        isExpanded: true,
        value: widget.vm.selectedCollection?.collectionName,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          int idx = widget.vm.collections
              .indexWhere((element) => element.collectionName == value);
          widget.vm.onSelectCollection(widget.vm.collections[idx]);
        },
        items: widget.vm.collections.map<DropdownMenuItem<String>>((element) {
          return DropdownMenuItem<String>(
            value: element.collectionName,
            child: Text(element.collectionName),
          );
        }).toList(),
      );
    } else {
      returnWidget = const Text("Fetching Data...");
    }
    return returnWidget;
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
