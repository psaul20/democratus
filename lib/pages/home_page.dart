import 'package:democratus/pages/add_proposal.dart';
import 'package:flutter/cupertino.dart';
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/proposal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/proposals_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<ProposalsModel>(
          builder: (context, proposals, child) => ListView.builder(
              itemCount: proposals.numProposals,
              itemBuilder: ((context, index) {
                Proposal proposal = proposals.getProposalByIndex(index);
                return Card(child: ProposalTile(proposal: proposal));
              }))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProposal(),
              ));
        },
        tooltip: 'Add Proposal',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProposalTile extends StatelessWidget {
  const ProposalTile({super.key, required this.proposal});
  final Proposal proposal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2, child: Text(proposal.shortTitle[0]["title"].toString())),
          Expanded(
            flex: 1,
            child: Text(
              "Last Action\n${DateFormat.yMMMd().format(proposal.lastModified)}",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
