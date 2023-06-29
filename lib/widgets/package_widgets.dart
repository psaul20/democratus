import 'package:democratus/main.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:democratus/models/package.dart';

class PackageListView extends StatelessWidget {
  const PackageListView({
    super.key,
    required this.packages,
  });
  final List<Package> packages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: packages.length,
        itemBuilder: ((context, index) {
          Package package = packages.elementAt(index);
          return PackageTile(package: package);
        }));
  }
}

class PackageTile extends ConsumerWidget {
  const PackageTile({super.key, required this.package});
  final Package package;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(savedPackagesProvider);
    onTap() {
      if (package.isSaved) {
        ref.read(savedPackagesProvider.notifier).removePackage(package);
        package.isSaved = false;
      } else {
        ref.read(savedPackagesProvider.notifier).savePackage(package);
        package.isSaved = true;
      }
    }

    return Card(
      child: ExpansionTile(
        title: Text(package.title),
        tilePadding: const EdgeInsets.only(left: 10, bottom: 0, right: 10),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 10),
            dense: true,
            title: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Last Action: ${DateFormat.yMMMd().format(package.lastModified)}",
                      textAlign: TextAlign.start,
                      style: TextStyles.expandedListTile,
                    ),
                  ],
                ),
                SaveButton(
                  isSaved: package.isSaved,
                  onTap: onTap,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
