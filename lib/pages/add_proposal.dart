import 'dart:developer';

import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

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

  searchProposals() async {
    return 
  }

  @override
  Widget build(BuildContext context) {
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
              FutureBuilder(
                future: getCollections(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  Widget returnWidget;
                  if (snapshot.hasData) {
                    CollectionList collections =
                        snapshot.data as CollectionList;
                    List collectionNames = collections.getCollectionNames();
                    returnWidget = CollectionDropDown(
                      names: collectionNames,
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
              )
              FutureBuilder(
                future: ,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  Widget returnWidget;
                  if (snapshot.hasData) {
                    CollectionList collections =
                        snapshot.data as CollectionList;
                    List collectionNames = collections.getCollectionNames();
                    returnWidget = CollectionDropDown(
                      names: collectionNames,
                    );
                  } else if (snapshot.hasError) {
                    log("Error fetching collections data");
                    returnWidget = const Text("Error fetching data");
                  } else {
                    returnWidget = const Text("Fetching Data...");
                  }
                  return returnWidget;
              })
            ],
          ),
        ));
  }
}

class CollectionDropDown extends StatefulWidget {
  const CollectionDropDown({super.key, required this.names});
  final List names;

  @override
  State<CollectionDropDown> createState() => _CollectionDropDownState();
}

class _CollectionDropDownState extends State<CollectionDropDown> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.names.first;
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
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
          dropdownValue = value!;
        });
      },
      items: widget.names.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
