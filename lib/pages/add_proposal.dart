import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:flutter/material.dart';

class AddProposal extends StatefulWidget {
  const AddProposal({super.key});

  @override
  State<AddProposal> createState() => _AddProposalState();
}

class _AddProposalState extends State<AddProposal> {
  CollectionList collections = await GovinfoApi().getCollections();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search Documents"),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [DropdownButton(items: , onChanged: onChanged)],
        ));
  }
}
