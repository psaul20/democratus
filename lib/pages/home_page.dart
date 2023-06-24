import 'package:democratus/pages/add_package.dart';
import 'package:democratus/widgets/package_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/package.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<PackageList>(
          builder: (context, packages, child) =>
              PackageListView(packages: packages)),
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
