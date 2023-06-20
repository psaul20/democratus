import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:flutter/material.dart';

class AddProposal extends StatefulWidget {
  const AddProposal({super.key});

  @override
  State<AddProposal> createState() => _AddProposalState();
}

class _AddProposalState extends State<AddProposal> {
  @override
  Future<void> initState() async {
    super.initState(
    CollectionList collections = await GovinfoApi().getCollections();
    List collectionNames = collections.getCollectionNames();
    String selectedCollection = collectionNames[0];
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search Documents"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ));
  }
}

class CollectionDropDown extends StatefulWidget {
  const CollectionDropDown({super.key, required this.collectionNames});
  final List collectionNames;

  @override
  State<CollectionDropDown> createState() => _CollectionDropDownState();
}

class _CollectionDropDownState extends State<CollectionDropDown> {
    String dropdownValue = widget.collectionNames.first;

  @override
  Widget build(BuildContext context) {

    
  }
}