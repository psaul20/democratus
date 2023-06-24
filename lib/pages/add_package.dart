import 'dart:developer';
import 'dart:ffi';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/widgets/package_widgets.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';

class AddProposal extends StatefulWidget {
  const AddProposal({super.key});

  @override
  State<AddProposal> createState() => _AddProposalState();
}

class _AddProposalState extends State<AddProposal> {
  // Memoize async function to prevent re-firing on rebuild
  final collectionsMemo = AsyncMemoizer();
  getCollections() async {
    return collectionsMemo.runOnce(
      () async {
        return await GovinfoApi().getCollections();
      },
    );
  }

  searchPackages() async {
    return await GovinfoApi()
        .searchPackages(startDate, endDate, collectionCodes);
  }

  submitSearch() {
    if (formKey.currentState!.validate()) {
      packages = searchPackages();
    }
  }

  late DateTime startDate;
  late DateTime endDate;
  late List collectionCodes;
  bool isCodeSelected = false;
  bool isDateInput = false;
  final formKey = GlobalKey<FormState>();
  late PackageList packages;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PackageList(),
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
                FutureBuilder(
                  future: getCollections(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    Widget returnWidget;
                    if (snapshot.hasData) {
                      CollectionList collections =
                          snapshot.data as CollectionList;
                      returnWidget = CollectionDropDown(
                        collections: collections,
                      );
                    } else if (snapshot.hasError) {
                      log("Error fetching collections data");
                      returnWidget = const Text("Error fetching data");
                    } else {
                      returnWidget = const Text("Fetching Data...");
                    }
                    return returnWidget;
                  },
                ),
                const Text('Published after date:'),
                InputDatePickerFormField(
                  firstDate: DateTime(1776, 1, 1),
                  lastDate: DateTime.now(),
                ),
                Consumer<PackageList>(
                  builder: (context, packages, child) {
                    Widget returnWidget;
                    if (packages.packages.isEmpty) {
                      returnWidget = const Expanded(
                        child: Center(
                            child: Text(
                          "Tap below to Search",
                          textAlign: TextAlign.center,
                        )),
                      );
                    } else {
                      returnWidget = PackageListView(packages: packages);
                    }
                    return returnWidget;
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: Consumer<PackageList>(
            builder: (context, packages, child) {
              double iconSize = 50.0;
              if (packages.packages.isEmpty) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: submitSearch,
                  iconSize: iconSize,
                );
              } else {
                return IconButton(
                  onPressed: packages.removeAll,
                  icon: const Icon(Icons.remove),
                  iconSize: iconSize,
                );
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}

class CollectionDropDown extends StatefulWidget {
  const CollectionDropDown({super.key, required this.collections});
  final CollectionList collections;

  @override
  State<CollectionDropDown> createState() => _CollectionDropDownState();
}

class _CollectionDropDownState extends State<CollectionDropDown> {
  late List<String> names;
  late String dropDownValue;
  late Collection selectedCollection;

  @override
  void initState() {
    names = widget.collections.getCollectionNames();
    dropDownValue = names.first;
    selectedCollection = widget.collections.collections.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        // This is called when the user selects an item.
        setState(() {
          dropDownValue = value!;
          int collectionPosition = names.indexOf(value);
          selectedCollection =
              widget.collections.collections.elementAt(collectionPosition);
        });
      },
      items: names.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
