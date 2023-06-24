import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/package.dart';

class PackageTile extends StatelessWidget {
  const PackageTile({super.key, required this.package});
  final Package package;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2, child: Text(package.shortTitle![0]["title"].toString())),
          Expanded(
            flex: 1,
            child: Text(
              "Last Action\n${DateFormat.yMMMd().format(package.lastModified)}",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PackageListView extends StatelessWidget {
  const PackageListView({
    super.key,
    required this.packages,
  });
  final PackageList packages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: packages.numPackages,
        itemBuilder: ((context, index) {
          Package package = packages.getPackagebyIndex(index);
          return Card(child: PackageTile(package: package));
        }));
  }
}
