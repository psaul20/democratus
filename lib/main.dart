// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/models/proposals_model.dart';
import 'package:flutter/material.dart';
import 'api/govinfo_api.dart';
import 'models/proposal.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Democratus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ProposalsModel(),
        child: const MyHomePage(
          title: 'Democratus',
        ),
      ),
    );
  }
}

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
  void _addTestProposal() async {
    ProposalsModel proposalsModel = context.read<ProposalsModel>();
    proposalsModel.add(await GovinfoApi().getProposalById("BILLS-111hr131enr"));
  }

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
                return ListTile(
                    leading: Text(proposal.category),
                    trailing: Text(proposal.packageId),
                    title: Text(proposal.shortTitle[0]["title"].toString()));
              }))),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTestProposal,
        tooltip: 'Add Proposal',
        child: const Icon(Icons.add),
      ),
    );
  }
}
